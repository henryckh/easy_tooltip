# easy_tooltip

An easy to integrate flutter library to create modern tooltip with customized content.
Mobile supported tooltip allows you to dislay text popup with a transparent overlay and dimiss the bubble by tapping anywhere of the screen. Compatible to flutter web but hover feature is not yet suppored. 

![easy_tooltip](https://user-images.githubusercontent.com/11421035/188837459-06ac8891-a6c9-4adf-aad0-5f484f3ce4e7.gif)

## Getting started

To add the UI as simple as: 
```dart
EasyTooltip(
  content: 'hello world',
  child: Icon(Icons.info_outlined),
),
```

## Advanced Usage

| Attribute | Description | Default |
| --- | --- | --- |
| text | `required` display text of the tooltip | null |
| child | `required` clickable child of the tooltip  | null |
| width | maximum width of the tooltip  | 200 |
| arrowHeight | Height of the arrow | 10 |
| borderRadius | Border Radius of the bubble | radius 10 |
| backgroundColor | Background color of the tooltip | blue |
| padding | Padding of the text content of bubble | symmetric 8, 10 |
| textStyle | Text style of display text | white, normal |
| onDismiss | Callback when the tooltip show and dismiss | null |
| onEasyTooltipTap | Callback when the tooltip child tapped | null |

```dart
EasyTooltip(
  text: 'hello world! hello world!hello world!hello world!hello world!hello world!hello world!hello world!',
  bubbleWidth: 300,
  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
  backgroundColor: const Color(0xFF385E9D),
  onEasyTooltipTap: () {
    debugPrint('child is tapped.');
  },
  onDismiss: () {
    debugPrint('tooltip is dismissed');
  },
  child: const Icon(Icons.info_outlined),
)
```

