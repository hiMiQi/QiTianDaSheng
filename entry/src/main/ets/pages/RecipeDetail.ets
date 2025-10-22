import router from '@ohos.router'

type RecipeItem = { id?: string; title: string; img: string }

@Entry
@Component
struct RecipeDetail {
  @State item: RecipeItem = { title: '', img: '' }
  @State steps: Array<string> = []

  aboutToAppear() {
    const params: any = router.getParams()
    if (params) {
      this.item = params.item || this.item
      this.steps = Array.isArray(params.steps) ? params.steps : []
    }
  }

  build() {
    Column() {
      // 顶部栏：返回 + 标题
      Row() {
        Row() {
          Text('←')
            .fontSize(22)
            .fontColor('#444')
        }
        .width(44)
        .height(44)
        .onClick(() => router.back())

        Text('菜谱详情')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor('#222')

        Row() {}
        .width(44)
        .height(44)
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16, top: 8, bottom: 4 })
      .justifyContent(FlexAlign.SpaceBetween)
      .border({ width: 0.5, color: '#EEE' })

      // 头图 + 标题
      Column() {
        if (this.item && this.item.img) {
          Image(this.item.img)
            .width('88%')
            .height(180)
            .objectFit(ImageFit.Cover)
            .borderRadius(12)
            .alignSelf(ItemAlign.Center)
        }
        Text(this.item?.title || '未知菜品')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .margin({ top: 20 })
      }
      .width('100%')
      .margin({ top: 12 })

      // 制作步骤
      Column() {
        Text('制作步骤')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .margin({ bottom: 8 })
        if (this.steps && this.steps.length > 0) {
          ForEach(this.steps, (s: string, i: number) => {
            Row() {
              Text(`${i + 1}.`)
                .fontSize(16)
                .fontColor('#666')
                .width(24)
              Text(s)
                .fontSize(16)
                .fontColor('#333')
            }
            .margin({ bottom: 10 })
          })
        } else {
          Text('暂无制作步骤')
            .fontSize(14)
            .fontColor('#999')
        }
      }
      .width('100%')
      .padding({ left: 20, right: 20, top: 18 })
      .layoutWeight(1)

      // 底部导航：返回列表
      Row() {
        Button('返回菜谱')
          .type(ButtonType.Capsule)
          .height(40)
          .layoutWeight(1)
          .margin({ left: 24, right: 24 })
          .onClick(() => router.replaceUrl({ url: 'pages/Recipe' }))
      }
      .width('50%')
      .height(68)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}