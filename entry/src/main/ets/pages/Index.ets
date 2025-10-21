import router from '@ohos.router'
@Entry
@Component
struct Index {
  @State notes: Array<any> = []
  @State selectedCategory: string = '全部'
  aboutToAppear() {
    const params: any = router.getParams();
    if (params && params.newNote) {
      this.notes = [params.newNote, ...this.notes];
    }
    if (this.notes.length === 0) {
      const now = new Date();
      this.notes = [
        { title: '读书笔记：《小王子》感悟', category: '学习', createdAt: this.formatDate(new Date(now.getTime() - 3*24*60*60*1000 + 9*60*60*1000)), content: '真正重要的东西用眼睛看不见。记下三个触动：驯服、责任、心之所向。' },
        { title: '每日计划：健身与学习', category: '日常', createdAt: this.formatDate(new Date(now.getTime() - 2*24*60*60*1000 + 8*60*60*1000)), content: '今日清单：晨跑 3km；英语口语 30min；算法题 2 道；晚餐清淡。' },
        { title: '工作记录：接口联调问题与解决', category: '学习', createdAt: this.formatDate(new Date(now.getTime() - 2*24*60*60*1000 + 12*60*60*1000)), content: '问题：签名校验失败。排查：时间戳时区偏差。解决：统一为 UTC 并加 5 分钟容错。' },
        { title: '生活随记：菜谱尝试与调整', category: '日常', createdAt: this.formatDate(new Date(now.getTime() - 1*24*60*60*1000 + 19*60*60*1000)), content: '尝试番茄牛腩：焯水去腥、低温慢炖 90min、配酸甜比例 1:1。下次减少盐。' },
        { title: '灵感速记：App 交互优化点', category: '学习', createdAt: this.formatDate(now), content: '快速添加入口固定底部；编辑页加字数显示；列表支持密度切换、长按批量操作。' },
      ];
    }
  }
  
  formatDate(d: Date): string {
    const pad = (n: number) => (n < 10 ? '0' + n : n.toString());
    return `${pad(d.getMonth() + 1)}月${pad(d.getDate())}日 ${pad(d.getHours())}:${pad(d.getMinutes())}`;
  }
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
          .onClick(() => router.pushUrl({ url: 'pages/Settings' }))
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
          .fontWeight(this.selectedCategory === '全部' ? FontWeight.Medium : FontWeight.Normal)
          .fontColor(this.selectedCategory === '全部' ? '#222222' : '#777777')
          .onClick(() => { this.selectedCategory = '全部' })

        Text('学习')
          .fontSize(16)
          .fontWeight(this.selectedCategory === '学习' ? FontWeight.Medium : FontWeight.Normal)
          .fontColor(this.selectedCategory === '学习' ? '#222222' : '#777777')
          .margin({ left: 16 })
          .onClick(() => { this.selectedCategory = '学习' })

        Text('日常')
          .fontSize(16)
          .fontWeight(this.selectedCategory === '日常' ? FontWeight.Medium : FontWeight.Normal)
          .fontColor(this.selectedCategory === '日常' ? '#222222' : '#777777')
          .margin({ left: 16 })
          .onClick(() => { this.selectedCategory = '日常' })
      }
      .width('100%')
      .padding({ left: 20, right: 20, bottom: 12 })
      .margin({ top: 25 })

      // 主内容区：笔记列表或空态（可滚动）
      Stack() {
        // 可滚动内容
        Scroll() {
          Column() {
            if (this.notes.length === 0) {
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
              .height('100%')
              .alignItems(HorizontalAlign.Center)
              .justifyContent(FlexAlign.Center)
            } else {
              ForEach(this.notes.filter((n: any) => this.selectedCategory === '全部' || n.category === this.selectedCategory), (note: any, index: number) => {
                Column() {
                  Text(note.title || '无标题')
                    .fontSize(18)
                    .fontWeight(FontWeight.Bold)
                  Text(note.content || '')
                    .fontSize(14)
                    .fontColor('#444444')
                    .margin({ top: 6 })
                    .maxLines(1)
                    .textOverflow({ overflow: TextOverflow.Ellipsis })
                  Text(note.createdAt)
                    .fontSize(12)
                    .fontColor('#9AA0A6')
                    .margin({ top: 8 })
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
          .padding({ left: 8, right: 8, top: 8, bottom: 0 })
        }

        // 悬浮添加按钮（右下角覆盖）
         Row() {
           Image($r('app.media.tianjia'))
             .width(64)
             .height(64)
             .onClick(() => {
               router.pushUrl({ url: 'pages/NoteEdit' })
             })
             .margin({ right: 24, bottom: 8 })
         }
         .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.End)
          .alignItems(VerticalAlign.Bottom)
          .hitTestBehavior(HitTestMode.Transparent)
      }
      .layoutWeight(1)

      // 底部导航：笔记 / 菜谱 / 待办（固定在最底部）
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