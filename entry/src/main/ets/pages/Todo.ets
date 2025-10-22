import router from '@ohos.router'
import { getTodos, toggleDone } from '../store/TodoStore'
@Entry
@Component
struct Index {
  @State todos: Array<any> = []
  @State keyword: string = ''
  aboutToAppear() {
    this.todos = getTodos();
  }
  build() {
    Column() {
      // 顶部图标独立置顶（右侧）
      Row() {
        Image($r('app.media.shezhi'))
          .width(24)
          .height(24)
          .onClick(() => router.pushUrl({ url: 'pages/Settings' }))
      }
      .width('100%')
      .padding({ left: 20, right: 20, top: 8, bottom: 0 })
      .justifyContent(FlexAlign.End)

      // 标题单独一行
      Row() {
        Text('待办')
          .fontSize(34)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
      .padding({ left: 20, right: 20, top: 4, bottom: 0 })
      .margin({ bottom: 8 })

      // 搜索栏（参考笔记页样式）
      Row() {
        Image($r('app.media.search'))
          .width(18)
          .height(18)
          .margin({ left: 12, right: 8 })
        TextInput({ placeholder: '搜索标题或内容' })
          .height(36)
          .backgroundColor('#00000000')
          .borderRadius(18)
          .fontSize(14)
          .flexGrow(1)
          .onChange((value: string) => { this.keyword = value })
      }
      .width('88%')
      .height(40)
      .backgroundColor('#F5F6F7')
      .borderRadius(20)
      .alignItems(VerticalAlign.Center)
      .padding({ left: 16, right: 16 })
      .margin({ top: 16, bottom: 18 })
      .alignSelf(ItemAlign.Center)

      // 主内容区：有数据则展示列表，否则空态
      if (this.todos.length === 0) {
        Column() {
          Image($r('app.media.xie'))
            .width(100)
            .height(100)
            .opacity(0.9)
            .margin({ left: 22 })
          Text('没有待办')
            .fontSize(18)
            .fontColor('#9AA0A6')
            .margin({ top: 12, right: 2 })
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .layoutWeight(1)
      } else {
        Stack() {
          Scroll() {
            Column() {
            // 使用关键字过滤
            ForEach(this.todos.filter((t: any) => (this.keyword.trim() === '' || (t.title?.includes(this.keyword) || t.detail?.includes(this.keyword)))), (t: any, i: number) => {
              Column() {
                Row() {
                  Text(t.done ? '☑' : '□')
                    .fontSize(20)
                    .fontColor(t.done ? '#9AA0A6' : '#9AA0A6')
                    .margin({ right: 12 })
                    .onClick(() => {
                      toggleDone(this.todos.indexOf(t))
                      this.todos = getTodos()
                    })
                  Text(t.title || '待办')
                    .fontSize(18)
                    .fontWeight(FontWeight.Bold)
                    .fontColor(t.done ? '#A0A7AF' : '#222222')
                    .layoutWeight(1)
                  Text(t.createdAt || '')
                    .fontSize(12)
                    .fontColor(t.done ? '#B0B7C3' : '#9AA0A6')
                }
                .width('100%')
                .padding({ left: 0, right: 0, top: 0, bottom: 0 })

                if (t.detail) {
                  Text(t.detail)
                    .fontSize(15)
                    .fontColor(t.done ? '#AAAAAA' : '#444444')
                    .margin({ top: 8 })
                    .textOverflow({ overflow: TextOverflow.Ellipsis })
                    .maxLines(1)
                    .padding({ left: 0, right: 0, bottom: 0 })
                    .maxLines(2)
                    .padding({ left: 20, right: 20, bottom: 14 })
                }
              }
              .width('100%')
              .backgroundColor('#FFFFFF')
              .border({ width: 1, color: '#E5E5E5' })
              .borderRadius(20)
              .padding({ left: 20, right: 20, top: 16, bottom: 16 })
              .margin({ left: 28, right: 28, top: 6, bottom: 10 })
              .alignItems(HorizontalAlign.Start)
            })
          }
        }
        .width('100%')
        .height('100%')
        .padding({ left: 8, right: 8, top: 0, bottom: 0 })
        .margin({ top: 0 })

          // 悬浮添加按钮覆盖显示（不占用垂直空间）
          Row() {
            Image($r('app.media.tianjia'))
              .width(64)
              .height(64)
              .onClick(() => { router.pushUrl({ url: 'pages/TodoEdit' }) })
              .margin({ right: 48, bottom: 25 })
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.End)
          .alignItems(VerticalAlign.Bottom)
          .hitTestBehavior(HitTestMode.Transparent)
        }
        .width('100%')
        .layoutWeight(1)
      }


      // 底部导航：笔记 / 菜谱 / 待办（固定在最底部）
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
      
        // 中间：菜谱
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

        // 右侧：我的
        Column() {
          Image($r('app.media.mine'))
            .width(24)
            .height(24)
          Text('我的')
            .fontSize(12)
            .fontColor('#999999')
            .margin({ top: 4 })
        }
        .alignItems(HorizontalAlign.Center)
        .justifyContent(FlexAlign.Center)
        .flexGrow(1)
        .onClick(() => { router.pushUrl({ url: 'pages/Mine' }) })
      }
      .width('100%')
      .height(72)
      .backgroundColor('#FFFFFF')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}