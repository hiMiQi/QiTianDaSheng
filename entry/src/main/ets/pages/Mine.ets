import router from '@ohos.router'

@Entry
@Component
struct Mine {
  build() {
    Column() {
      // 顶部：标题
      Row() {
        Text('我的')
          .fontSize(34)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
      .padding({ left: 20, right: 20, top: 12, bottom: 8 })

      // 主内容区：登录入口
      Column() {
        Image($r('app.media.mine'))
          .width(64)
          .height(64)
        Text('个人中心')
          .fontSize(18)
          .fontColor('#333')
          .margin({ top: 8 })
        Button('登录')
          .type(ButtonType.Capsule)
          .height(36)
          .margin({ top: 16 })
          .onClick(() => router.pushUrl({ url: 'pages/Login' }))
      }
      .width('100%')
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)

      // 底部导航：笔记 / 菜谱 / 待办 / 我的
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
        .onClick(() => { router.replaceUrl({ url: 'pages/Index' }) })

        Column() {
          Image($r('app.media.cai'))
            .width(24)
            .height(24)
          Text('菜谱')
            .fontSize(12)
            .fontColor('#999999')
            .margin({ top: 4 })
        }
        .alignItems(HorizontalAlign.Center)
        .justifyContent(FlexAlign.Center)
        .flexGrow(1)
        .onClick(() => { router.replaceUrl({ url: 'pages/Recipe' }) })

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
        .onClick(() => { router.replaceUrl({ url: 'pages/Todo' }) })

        Column() {
          Image($r('app.media.mine_active'))
            .width(24)
            .height(24)
          Text('我的')
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