import router from '@ohos.router'
@Entry
@Component
struct Index {
  build() {
    Column() {
      // 顶部图标独立置顶（右侧）
      Row() {
        Image($r('app.media.wenjianjia'))
          .width(24)
          .height(24)
          .margin({ right: 16 })
        Image($r('app.media.shezhi'))
          .width(24)
          .height(24)
      }
      .width('100%')
      .padding({ left: 20, right: 20, top: 12, bottom: 0 })
      .justifyContent(FlexAlign.End)

      // 标题单独一行
      Row() {
        Text('记录')
          .fontSize(34)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
      .padding({ left: 20, right: 20, top: 8, bottom: 8 })

      // 分类/导航：全部 学习 导航栏（整体下移一些）
      Row() {
        Text('全部')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#222222')

        Text('学习')
          .fontSize(16)
          .fontColor('#777777')
          .margin({ left: 16 })

        Text('日常')
          .fontSize(16)
          .fontColor('#777777')
          .margin({ left: 16 })
      }
      .width('100%')
      .padding({ left: 20, right: 20, bottom: 12 })
      .margin({ top: 25 })

      // 主内容区（中间空态）
      Column() {
        Image($r('app.media.xie'))
          .width(100)
          .height(100)
          .opacity(0.9)
          .margin({ left: 24 })
        Text('没有笔记')
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
          .onClick(() => {
            router.pushUrl({ url: 'pages/AddNote' })
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.End)
      .padding({ right: 24, bottom: 24 })

      // 底部导航：笔记 / 待办（固定在最底部）
      Row() {
        Column() {
          Image($r('app.media.caidan_active'))
            .width(24)
            .height(24)
          Text('笔记')
            .fontSize(12)
            .fontColor('#000000')
            .margin({ top: 4 })
        }
        .alignItems(HorizontalAlign.Center)
        .justifyContent(FlexAlign.Center)
        .flexGrow(1)

        Column() {
          Image($r('app.media.daiban'))
            .width(24)
            .height(24)
          Text('待办')
            .fontSize(12)
            .fontColor('#999999')
            .margin({ top: 4 })
        }
        .alignItems(HorizontalAlign.Center)
        .justifyContent(FlexAlign.Center)
        .flexGrow(1)
        .onClick(() => {
          router.pushUrl({ url: 'pages/Todo' })
        })
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