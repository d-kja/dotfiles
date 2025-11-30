pragma ComponentBehavior: Bound
import Quickshell.Io

/*
 * INFO: Base colors
 *
 * You can updated this object to reflect the rest of the application
 **/
JsonObject {
  id: colors_root

  component Background: JsonObject {
    readonly property string primary: color.zinc_950
    readonly property string primary_foreground: color.zinc_100

    readonly property string secondary: color.zinc_800
    readonly property string secondary_foreground: color.zinc_300

    readonly property string accent: color.indigo_800
    readonly property string accent_foreground: color.indigo_300
  }

  component Border: JsonObject {
    readonly property string primary: color.zinc_800
    readonly property string primary_foreground: color.zinc_200

    readonly property string secondary: color.zinc_600
    readonly property string secondary_foreground: color.zinc_500

    readonly property string accent: color.indigo_800
    readonly property string accent_foreground: color.indigo_300
  }

  component Text: JsonObject {
    readonly property string primary: color.zinc_100
    readonly property string primary_foreground: color.zinc_950

    readonly property string secondary: color.zinc_200
    readonly property string secondary_foreground: color.zinc_950
  }

  /*
   * INFO: You can use tailwind as a reference: https://tailscan.com/colors
   **/
  property JsonObject colors: JsonObject {
    id: color

    readonly property string zinc_50: "#fafafa"
    readonly property string zinc_100: "#f4f4f5"
    readonly property string zinc_200: "#e4e4e7"
    readonly property string zinc_300: "#d4d4d8"
    readonly property string zinc_400: "#a1a1aa"
    readonly property string zinc_500: "#71717a"
    readonly property string zinc_600: "#52525b"
    readonly property string zinc_700: "#3f3f46"
    readonly property string zinc_800: "#27272a"
    readonly property string zinc_900: "#18181b"
    readonly property string zinc_950: "#09090b"

    readonly property string indigo_50: "#eef2ff"
    readonly property string indigo_100: "#e0e7ff"
    readonly property string indigo_200: "#c7d2fe"
    readonly property string indigo_300: "#a5b4fc"
    readonly property string indigo_400: "#818cf8"
    readonly property string indigo_500: "#6366f1"
    readonly property string indigo_600: "#4f46e5"
    readonly property string indigo_700: "#4338ca"
    readonly property string indigo_800: "#3730a3"
    readonly property string indigo_900: "#312e81"
    readonly property string indigo_950: "#1e1b4b"
  }
}
