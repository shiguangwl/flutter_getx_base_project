#!/bin/bash

# 自动生成 R.dart 资源文件的脚本
# 使用方法: ./scripts/generate_resources.sh [--verbose|-v]

set -e  # 遇到错误立即退出

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 全局变量
VERBOSE=false
RESOURCE_MAP=()
IMAGE_RESOURCES=()
OTHER_RESOURCES=()

# 解析命令行参数
parse_args() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            --verbose|-v)
                VERBOSE=true
                shift
                ;;
            *)
                echo "未知参数: $1"
                exit 1
                ;;
        esac
    done
}

# 转换为驼峰命名法
to_camel_case() {
    local filename="$1"
    # 移除文件扩展名
    local name_without_ext="${filename%.*}"
    
    # 处理下划线、连字符和空格
    local result=""
    local first_word=true
    
    # 使用 IFS 分割字符串
    IFS='_- ' read -ra words <<< "$name_without_ext"
    
    for word in "${words[@]}"; do
        if [[ -n "$word" ]]; then
            if [[ "$first_word" == true ]]; then
                # 第一个单词全小写
                result+=$(echo "$word" | tr '[:upper:]' '[:lower:]')
                first_word=false
            else
                # 后续单词首字母大写，其余小写
                local capitalized=$(echo "${word:0:1}" | tr '[:lower:]' '[:upper:]')$(echo "${word:1}" | tr '[:upper:]' '[:lower:]')
                result+="$capitalized"
            fi
        fi
    done
    
    # 如果结果为空，返回默认值
    if [[ -z "$result" ]]; then
        result="resource"
    fi
    
    echo "$result"
}

# 检查是否为资源文件
is_resource_file() {
    local extension="$1"
    local ext_lower=$(echo "$extension" | tr '[:upper:]' '[:lower:]')
    
    case "$ext_lower" in
        png|jpg|jpeg|gif|webp|svg|bmp|ico|mp3|wav|ogg|aac|mp4|avi|mov|wmv|flv|json|xml|txt|md|ttf|otf|woff|woff2|pdf|doc|docx|xls|xlsx)
            return 0
            ;;
        *)
            return 1
            ;;
    esac
}

# 递归扫描目录
scan_directory() {
    local dir="$1"
    local relative_path="$2"
    
    if [[ ! -d "$dir" ]]; then
        return
    fi
    
    # 遍历目录中的文件和子目录
    while IFS= read -r -d '' item; do
        if [[ -f "$item" ]]; then
            # 处理文件
            local filename=$(basename "$item")
            local extension="${filename##*.}"
            
            if is_resource_file "$extension"; then
                local full_path="assets/$relative_path$filename"
                local constant_name=$(to_camel_case "$filename")
                
                # 避免重复命名
                local final_name="$constant_name"
                local counter=1
                while [[ " ${RESOURCE_MAP[*]} " =~ " ${final_name}:" ]]; do
                    final_name="${constant_name}_${counter}"
                    ((counter++))
                done
                
                # 添加到资源映射
                RESOURCE_MAP+=("${final_name}:${full_path}")
                
                # 分类资源
                if [[ "$full_path" == *"/images/"* ]]; then
                    IMAGE_RESOURCES+=("${final_name}:${full_path}")
                else
                    OTHER_RESOURCES+=("${final_name}:${full_path}")
                fi
                
                if [[ "$VERBOSE" == true ]]; then
                    echo "  ${final_name}: ${full_path}"
                fi
            fi
        elif [[ -d "$item" ]]; then
            # 递归处理子目录
            local dirname=$(basename "$item")
            local new_relative_path="$relative_path"
            if [[ -n "$relative_path" ]]; then
                new_relative_path="${relative_path}${dirname}/"
            else
                new_relative_path="${dirname}/"
            fi
            scan_directory "$item" "$new_relative_path"
        fi
    done < <(find "$dir" -mindepth 1 -maxdepth 1 -print0)
}

# 生成 R.dart 文件内容
generate_r_file_content() {
    local content=""
    
    # 文件头
    content+="/// 资源文件管理类\n"
    content+="/// 统一管理应用中的图片、字符串等资源\n"
    content+="/// 此文件由脚本自动生成，请勿手动修改\n"
    content+="/// 生成时间: $(date -u +"%Y-%m-%dT%H:%M:%SZ")\n"
    content+="class R {\n"
    content+="  // 私有构造函数，防止实例化\n"
    content+="  R._();\n"
    content+="\n"
    
    # 图片资源
    if [[ ${#IMAGE_RESOURCES[@]} -gt 0 ]]; then
        content+="  // 图片资源\n"
        for resource in "${IMAGE_RESOURCES[@]}"; do
            local name="${resource%%:*}"
            local path="${resource#*:}"
            content+="  static const String $name = '$path';\n"
        done
        content+="\n"
    fi
    
    # 其他资源
    if [[ ${#OTHER_RESOURCES[@]} -gt 0 ]]; then
        content+="  // 其他资源\n"
        for resource in "${OTHER_RESOURCES[@]}"; do
            local name="${resource%%:*}"
            local path="${resource#*:}"
            content+="  static const String $name = '$path';\n"
        done
        content+="\n"
    fi
    
    # 获取所有图片资源路径
    if [[ ${#IMAGE_RESOURCES[@]} -gt 0 ]]; then
        content+="  /// 获取所有图片资源路径\n"
        content+="  static List<String> get allImages => [\n"
        for resource in "${IMAGE_RESOURCES[@]}"; do
            local name="${resource%%:*}"
            content+="    $name,\n"
        done
        content+="  ];\n"
        content+="\n"
    fi
    
    # 获取所有资源路径
    content+="  /// 获取所有资源路径\n"
    content+="  static List<String> get allResources => [\n"
    for resource in "${RESOURCE_MAP[@]}"; do
        local name="${resource%%:*}"
        content+="    $name,\n"
    done
    content+="  ];\n"
    content+="\n"
    
    # 根据资源名称获取路径
    content+="  /// 根据资源名称获取路径\n"
    content+="  static String? getResourcePath(String name) {\n"
    content+="    switch (name) {\n"
    for resource in "${RESOURCE_MAP[@]}"; do
        local name="${resource%%:*}"
        content+="      case '$name': return $name;\n"
    done
    content+="      default: return null;\n"
    content+="    }\n"
    content+="  }\n"
    content+="}\n"
    
    echo -e "$content"
}

# 主函数
main() {
    echo -e "${BLUE}🚀 开始生成 R.dart 资源文件...${NC}"
    
    # 解析命令行参数
    parse_args "$@"
    
    # 检查是否在项目根目录
    if [[ ! -f "pubspec.yaml" ]]; then
        echo -e "${RED}❌ 请在项目根目录运行此脚本！${NC}"
        exit 1
    fi
    
    # 检查 assets 文件夹是否存在
    if [[ ! -d "assets" ]]; then
        echo -e "${RED}❌ assets 文件夹不存在！${NC}"
        exit 1
    fi
    
    # 扫描资源文件
    echo -e "${YELLOW}📁 扫描资源文件...${NC}"
    scan_directory "assets" ""
    
    if [[ ${#RESOURCE_MAP[@]} -eq 0 ]]; then
        echo -e "${YELLOW}⚠️  未找到任何资源文件！${NC}"
        exit 0
    fi
    
    # 显示扫描结果
    if [[ "$VERBOSE" == true ]]; then
        echo -e "\n${BLUE}📋 生成的资源列表：${NC}"
        for resource in "${RESOURCE_MAP[@]}"; do
            local name="${resource%%:*}"
            local path="${resource#*:}"
            echo "  $name: $path"
        done
    fi
    
    # 生成 R.dart 文件内容
    echo -e "${YELLOW}📝 生成 R.dart 文件...${NC}"
    local content=$(generate_r_file_content)
    
    # 写入文件
    echo -e "$content" > "lib/R.dart"
    
    echo -e "${GREEN}✅ R.dart 文件生成完成！${NC}"
    echo -e "${GREEN}📊 共映射了 ${#RESOURCE_MAP[@]} 个资源文件${NC}"
    
    echo -e "\n${BLUE}💡 使用提示：${NC}"
    echo -e "  - 在代码中使用: ${YELLOW}Image.asset(R.logo)${NC}"
    echo -e "  - 获取所有图片: ${YELLOW}R.allImages${NC}"
    echo -e "  - 动态获取资源: ${YELLOW}R.getResourcePath(\"logo\")${NC}"
    
    echo -e "\n${GREEN}✅ 脚本执行完成！${NC}"
}

# 运行主函数
main "$@"
