import router from '@ohos.router'

@Entry
@Component
struct Login {
  @State account: string = ''
  @State password: string = ''

  build() {
    Column() {
      // 顶部品牌区
      Column() {
        Image($r('app.media.icon'))
          .width(64)
          .height(64)
          .margin({ bottom: 8 })
        Text('小栖云 RestCloud')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor('#222')
      }
      .width('100%')
      .padding({ top: 48 })
      .alignItems(HorizontalAlign.Center)

      // 登录表单
      Column() {
        // 账号
        Row() {
          Image($r('app.media.search'))
            .width(18)
            .height(18)
            .margin({ left: 12, right: 8 })
          TextInput({ placeholder: '手机号 / 邮箱' })
            .height(40)
            .backgroundColor('#00000000')
            .borderRadius(20)
            .fontSize(14)
            .flexGrow(1)
            .onChange((v: string) => { this.account = v })
        }
        .width('88%')
        .height(44)
        .backgroundColor('#F5F6F7')
        .borderRadius(22)
        .alignItems(VerticalAlign.Center)
        .padding({ left: 16, right: 16 })
        .margin({ top: 24 })
        .alignSelf(ItemAlign.Center)

        // 密码
        Row() {
          Image($r('app.media.gou'))
            .width(18)
            .height(18)
            .margin({ left: 12, right: 8 })
          TextInput({ placeholder: '密码' })
            .height(40)
            .backgroundColor('#00000000')
            .borderRadius(20)
            .fontSize(14)
            .flexGrow(1)
            .onChange((v: string) => { this.password = v })
        }
        .width('88%')
        .height(44)
        .backgroundColor('#F5F6F7')
        .borderRadius(22)
        .alignItems(VerticalAlign.Center)
        .padding({ left: 16, right: 16 })
        .margin({ top: 14 })
        .alignSelf(ItemAlign.Center)

        // 登录按钮
        Button('登录')
          .type(ButtonType.Capsule)
          .height(44)
          .width('88%')
          .margin({ top: 24 })
          .onClick(() => {
            // 简单模拟登录成功，跳转首页
            router.replaceUrl({ url: 'pages/Index' })
          })

        // 辅助链接
        Row() {
          Text('忘记密码')
            .fontSize(12)
            .fontColor('#888')
          Text('注册')
            .fontSize(12)
            .fontColor('#3B82F6')
            .margin({ left: 18 })
        }
        .width('88%')
        .margin({ top: 12 })
        .alignSelf(ItemAlign.Center)
        .justifyContent(FlexAlign.End)
      }
      .layoutWeight(1)

      // 底部导航：返回或跳过登录
      Row() {
        Button('跳过，稍后登录')
          .type(ButtonType.Capsule)
          .height(36)
          .onClick(() => router.replaceUrl({ url: 'pages/Index' }))
      }
      .width('100%')
      .height(72)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor('#FFFFFF')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}