#!/bin/sh

# Функция для генерации ключевых слов на основе архитектуры
generate_keyword() {
    local architecture="$1"
    local model_name="$2"
    local generated_keyword
    
    case "$(echo "$architecture$model_name" | tr '[:upper:]' '[:lower:]')" in
        *"aarch64"* | *"cortex-a53"*)
            generated_keyword="aarch64_cortex-a53"
            ;;
        *"aarch64"* | *"cortex-a72"*)
            generated_keyword="aarch64_cortex-a72"
            ;;
        *"aarch64"* | *"generic"*)
            generated_keyword="aarch64_generic"
            ;;
        *"arm"* | *"arm1176jzf-s"* | *"vfp"*)
            generated_keyword="arm_arm1176jzf-s_vfp"
            ;;
        *"arm"* | *"cortex-a15"* | *"neon-vfpv4"*)
            generated_keyword="arm_cortex-a15_neon-vfpv4"
            ;;
        *"arm"* | *"cortex-a5"* | *"vfpv4"*)
            generated_keyword="arm_cortex-a5_vfpv4"
            ;;
        *"arm"* | *"cortex-a7"* | *"neon-vfpv4"*)
            generated_keyword="arm_cortex-a7_neon-vfpv4"
            ;;
        *"arm"* | *"cortex-a8"* | *"vfpv3"* | *"cortex-a9"* | *"vfpv3-d16"* | *"mpcore"*)
            generated_keyword="arm_generic"
            ;;
        *"i386"* | *"pentium-mmx"*)
            generated_keyword="i386_pentium-mmx"
            ;;
        *"i386"* | *"pentium4"*)
            generated_keyword="i386_pentium4"
            ;;
        *"mipsel"* | *"24"*)
            generated_keyword="mipsel_24kc"
            ;;
        *"mipsel"* | *"74"*)
            generated_keyword="mipsel_74kc"
            ;;
        *"mipsel"* | *"mips32"*)
            generated_keyword="mipsel_mips32"
            ;;
        *"mips"* | *"24"*)
            generated_keyword="mips_24kc"
            ;;
        *"mips"* | *"mips32"*)
            generated_keyword="mips_mips32"
            ;;
        *)
            generated_keyword=""
            ;;
    esac
	
	echo "$generated_keyword"
}