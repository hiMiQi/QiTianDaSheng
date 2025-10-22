import router from '@ohos.router'
import promptAction from '@ohos.promptAction'

@Entry
@Component
struct Mine {
  @StorageLink('loggedIn') loggedIn: boolean = false
  build() {
    Column() {
      // 顶部：标题
      Row() {
        Text('   ')
          .fontSize(34)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
      .padding({ left: 20, right: 20, top: 12, bottom: 8 })

      // 主内容区：登录入口 / 已登录信息
      if (this.loggedIn) {
        Column() {
          // 顶部信息卡（模拟渐变背景）
          Column() {

            Row() {
              Image($r('app.media.mine'))
                .width(64)
                .height(64)
                .borderRadius(32)
                .backgroundColor('#FFFFFF')
              Column() {
                Text('用户名称')
                  .fontSize(20)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#FFFFFF')
                Text('账号ID: admin')
                  .fontSize(14)
                  .fontColor('#EAF6FF')
                  .margin({ top: 6 })
              }
              .margin({ left: 16 })
            }
            .width('100%')
            .padding({ left: 20, right: 20, top: 24, bottom: 14 })
          }
          .width('100%')
          .height(180)
          .backgroundColor('#36C7F3')
          .borderRadius(16)

          // 中部列表卡片
          Column() {
            // 账号安全
            Row() {
              Text('账号安全')
                .fontSize(16)
                .fontColor('#333333')
              Text('>')
                .fontSize(18)
                .fontColor('#C0C4CC')
            }
            .width('100%')
            .height(56)
            .padding({ left: 20, right: 20 })
            .justifyContent(FlexAlign.SpaceBetween)
            .border({ width: 0.5, color: '#EEEEEE' })
            .onClick(() => {
              promptAction.showToast({ message: '账号安全：开发中' })
            })

            // 存储空间
            Row() {
              Text('存储空间')
                .fontSize(16)
                .fontColor('#333333')
              Text('>')
                .fontSize(18)
                .fontColor('#C0C4CC')
            }
            .width('100%')
            .height(56)
            .padding({ left: 20, right: 20 })
            .justifyContent(FlexAlign.SpaceBetween)
            .border({ width: 0.5, color: '#EEEEEE' })
            .onClick(() => {
              promptAction.showToast({ message: '存储空间：开发中' })
            })

            // 消息通知
            Row() {
              Text('消息通知')
                .fontSize(16)
                .fontColor('#333333')
              Text('>')
                .fontSize(18)
                .fontColor('#C0C4CC')
            }
            .width('100%')
            .height(56)
            .padding({ left: 20, right: 20 })
            .justifyContent(FlexAlign.SpaceBetween)
            .border({ width: 0.5, color: '#EEEEEE' })
            .onClick(() => {
              promptAction.showToast({ message: '消息通知：开发中' })
            })

            // 帮助中心
            Row() {
              Text('帮助中心')
                .fontSize(16)
                .fontColor('#333333')
              Text('>')
                .fontSize(18)
                .fontColor('#C0C4CC')
            }
            .width('100%')
            .height(56)
            .padding({ left: 20, right: 20 })
            .justifyContent(FlexAlign.SpaceBetween)
            .border({ width: 0.5, color: '#EEEEEE' })
            .onClick(() => {
              promptAction.showToast({ message: '帮助中心：开发中' })
            })

            // 设置（跳转到已有设置页）
            Row() {
              Text('设置')
                .fontSize(16)
                .fontColor('#333333')
              Text('>')
                .fontSize(18)
                .fontColor('#C0C4CC')
            }
            .width('100%')
            .height(56)
            .padding({ left: 20, right: 20 })
            .justifyContent(FlexAlign.SpaceBetween)
            .onClick(() => router.pushUrl({ url: 'pages/Settings' }))
          }
          .width('90%')
          .backgroundColor('#FFFFFF')
          .borderRadius(16)
          .margin({ top: 12 })
          .alignSelf(ItemAlign.Center)

          // 底部退出登录按钮
          Button('退出登录')
             .type(ButtonType.Capsule)
             .height(44)
             .width('88%')
             .margin({ top: 14 })
             .fontSize(16)
             .fontColor('#36C7F3')
             .backgroundColor('#E6F7FF')
             .border({ width: 1, color: '#36C7F3' })
             .onClick(() => {
               AppStorage.SetOrCreate('loggedIn', false);
               router.replaceUrl({ url: 'pages/Index' })
             })
        }
        .width('100%')
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)
        .justifyContent(FlexAlign.Start)
      } else {
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
      }

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
        .onClick(() => {
          router.pushUrl({ url: 'pages/Todo' })
        })

        // 右侧：我的
        Column() {
          Image($r('app.media.mine'))
            .width(24)
            .height(24)
          Text('我的')
            .fontSize(12)
            .fontColor('#999999')
        }
        .alignItems(HorizontalAlign.Center)
        .justifyContent(FlexAlign.Center)
        .flexGrow(1)
        .onClick(() => { router.pushUrl({ url: 'pages/Mine' }) })
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