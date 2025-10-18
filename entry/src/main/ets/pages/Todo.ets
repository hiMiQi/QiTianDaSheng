import router from '@ohos.router'
@Entry
@Component
struct Index {
  build() {
    Column() {
      // 顶部图标独立置顶（右侧）
      Row() {
        Image($r('app.media.shezhi'))
          .width(24)
          .height(24)
      }
      .width('100%')
      .padding({ left: 20, right: 20, top: 12, bottom: 0 })
      .justifyContent(FlexAlign.End)

      // 标题单独一行
      Row() {
        Text('待办')
          .fontSize(34)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
      .padding({ left: 20, right: 20, top: 8, bottom: 8 })

      // 主内容区（中间空态）
      Column() {
        Image($r('app.media.daiban'))
          .width(100)
          .height(100)
          .opacity(0.9)
          .margin({ left: 2 })
        Text('没有待办')
          .fontSize(18)
          .fontColor('#9AA0A6')
          .margin({ top: 12, right: 2 })
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .layoutWeight(1)

      // 悬浮添加按钮：位于底部导航上方，右下角
      Row() {
        Image($r('app.media.tianjia'))
          .width(64)
          .height(64)
      }
      .width('100%')
      .justifyContent(FlexAlign.End)
      .padding({ right: 24, bottom: 24 })

      // 底部导航：笔记 / 待办（固定在最底部）
      Row() {
        Column() {
          Image($r('app.media.caidan'))
            .width(24)
            .height(24)
          Text('笔记')
            .fontSize(12)
            .fontColor('#999999')
            .margin({ top: 4 })
        }
        .alignItems(HorizontalAlign.Center)
        .justifyContent(FlexAlign.Center)
        .flexGrow(1)
        .onClick(() => {
          router.pushUrl({ url: 'pages/Index' })
        })

        Column() {
          Image($r('app.media.daiban_active'))
            .width(24)
            .height(24)
          Text('待办')
            .fontSize(12)
            .fontColor('#000000')
            .margin({ top: 4 })
        }
        .alignItems(HorizontalAlign.Center)
        .justifyContent(FlexAlign.Center)
        .flexGrow(1)
      }
      .width('100%')
      .height(72)
      .backgroundColor('#FFFFFF')
      .border({ width: 0.5, color: '#EEEEEE' })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}