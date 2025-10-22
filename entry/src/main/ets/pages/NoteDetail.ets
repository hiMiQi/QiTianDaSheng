import router from '@ohos.router';

type NoteItem = { id?: string; title: string; content: string; createdAt?: string; category?: string }

@Entry
@Component
struct NoteDetail {
  @State note: NoteItem = { title: '', content: '' }

  aboutToAppear() {
    const params = router.getParams() as { note?: NoteItem };
    if (params && params.note) {
      this.note = params.note;
    }
  }

  build() {
    Column() {
      // 顶部栏：返回（独立一行）
      Row() {
        Text('<')
          .fontSize(18)
          .fontColor('#5F6368')
          .margin({ right: 6 })
        Text('返回')
          .fontSize(16)
          .fontColor('#5F6368')
      }
      .onClick(() => { router.back() })
      .width('100%')
      .height(44)
      .padding({ left: 16, right: 16, top: 8, bottom: 4 })
      .alignItems(VerticalAlign.Center)

      // 标题单独一行
      Text(this.note.title || '无标题')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .padding({ left: 20, right: 20 })
        .margin({ top: 18, bottom: 22 })
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })

      // 信息区：分类 + 时间（紧跟标题）
      Row() {
        if (this.note.category) {
          Text(this.note.category)
            .fontSize(12)
            .fontColor('#5F6368')
            .backgroundColor('#F6F7F9')
            .borderRadius(12)
            .padding({ left: 10, right: 10, top: 4, bottom: 4 })
        }
        if (this.note.createdAt) {
          Text('·')
            .fontSize(12)
            .fontColor('#B0B7C3')
            .margin({ left: 8, right: 8 })
          Text(this.note.createdAt)
            .fontSize(12)
            .fontColor('#9AA0A6')
        }
      }
      .width('100%')
      .padding({ left: 20, right: 20, bottom: 6 })

      // 内容区（可滚动）
      Scroll() {
        Column() {
          Text(this.note.content || '')
            .fontSize(16)
            .fontColor('#333333')
            .lineHeight(26)
            .margin({ top: 8 })
        }
        .width('100%')
        .padding({ left: 20, right: 20, top: 10, bottom: 60 })
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}