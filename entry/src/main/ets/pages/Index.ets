import router from '@ohos.router'
import promptAction from '@ohos.promptAction'
@Entry
@Component
struct Index {
  @State notes: Array<any> = []
  @State selectedCategory: string = '全部'
  @State keyword: string = ''
  private longPressTimer: number = -1
  private longPressTriggered: boolean = false
  aboutToAppear() {
    const params: any = router.getParams();
    // 先初始化默认数据（避免添加新笔记时只剩一条）
    if (this.notes.length === 0) {
      const now = new Date();
      this.notes = [
        { title: '读书笔记：《小王子》感悟', category: '学习', createdAt: this.formatDate(new Date(now.getTime() - 3*24*60*60*1000 + 9*60*60*1000)), content: '关键词：驯服、责任、看不见的本质。\n摘录：\n1）只有用心才能看得清楚，本质的东西用眼睛是看不见的。\n2）你要对你驯服的一切负责。\n3）星星之所以美，是因为某一颗星上有一朵你看不见的玫瑰。\n思考：在人际关系里，“驯服”意味着建立独特的联系；在工作里，责任让选择更有意义；保持童心，是对复杂世界的温柔抵抗。' },
        { title: '每日计划：健身与学习', category: '日常', createdAt: this.formatDate(new Date(now.getTime() - 2*24*60*60*1000 + 8*60*60*1000)), content: '目标：体能+专注双提升。\n清单：\n1）晨跑 3km（配速 6\'20）\n2）英语口语 30min（跟读+复述）\n3）算法题 2 道（滑动窗口 / 二分）\n4）拉伸 10min；晚餐清淡（高蛋白）。\n打卡备注：跑后心率 150→120；口语复述更流畅。' },
        { title: '工作记录：接口联调问题与解决', category: '学习', createdAt: this.formatDate(new Date(now.getTime() - 2*24*60*60*1000 + 12*60*60*1000)), content: '背景：第三方平台回调验签失败。\n症状：服务端报 401，客户端重试无效。\n排查：发现时间戳使用本地时区，导致与平台 UTC 相差 8h。\n修复：统一为 UTC + 容错 5min；签名串按字段排序并去空格。\n验证：联调通过，误报率降至 0.2%。\n后续：加入 NTP 校时与告警。' },
        { title: '灵感速记：App 交互优化点', category: '学习', createdAt: this.formatDate(now), content: '交互优化清单：\n• 快速添加入口固定底部，支持长按选择模板\n• 编辑页显示字数与阅读时长估算\n• 列表支持密度切换（舒适 / 紧凑）\n• 批量操作：长按进入多选，合并 / 移动到笔记本\n• 搜索联想：匹配标题、标签与最近访问' },
        { title: '读书笔记：《人类简史》摘记', category: '学习', createdAt: this.formatDate(new Date(now.getTime() - 5*24*60*60*1000 + 7*60*60*1000)), content: '主题：从认知革命到科学革命。\n摘录：\n1）虚构故事是大规模协作的基础。\n2）农业革命并未让个体更幸福。\n3）科学革命重塑了人类与世界的关系。\n思考：技术与制度的叠加效应，决定了文明的走向；保持对“幸福感”的度量与反思。' },
        { title: '随笔：专注力训练小结', category: '日常', createdAt: this.formatDate(new Date(now.getTime() - 1*24*60*60*1000 + 6*60*60*1000)), content: '方法：番茄钟 25min×4；站立工作；降噪耳机白噪声。\n记录：早间效率最高；午后需要轻度运动激活。\n改进：任务拆分更细、减少上下文切换、设定明确停表动作。' },
        { title: '观影笔记：《海蒂和爷爷》', category: '日常', createdAt: this.formatDate(new Date(now.getTime() - 6*24*60*60*1000 + 20*60*60*1000)), content: '关键词：自由、成长、陪伴。\n片段：阿尔卑斯的温暖与城市礼法的冲撞。\n感受：好的教育是尊重天性与给予安全感。' },
        { title: '技术笔记：列表虚拟化与性能', category: '学习', createdAt: this.formatDate(new Date(now.getTime() - 4*24*60*60*1000 + 14*60*60*1000)), content: '问题：长列表卡顿。\n方案：窗口化渲染、按需加载、骨架屏占位。\n指标：首屏 1.2s→0.7s，滚动丢帧率降至 3%。\n注意：图片尺寸规范与缓存策略同样关键。' },
        { title: '旅行清单：周末露营准备', category: '日常', createdAt: this.formatDate(new Date(now.getTime() - 3*24*60*60*1000 + 10*60*60*1000)), content: '必备：帐篷/地垫/睡袋；头灯；便携炉。\n食物：高蛋白与耐储存；补水充足。\n安全：天气预报、路线分享、备用电源。' },
          { title: '生活随记：晨间仪式与睡眠', category: '日常', createdAt: this.formatDate(new Date(now.getTime() - 1*24*60*60*1000 + 21*60*60*1000)), content: '晨间：拉伸 5min、呼吸练习 3min、阳光照射 10min。\n睡眠：固定入睡时间；卧室降噪与遮光；减少睡前屏幕。\n感受：清醒度提升，午后困倦减少，入睡更快。' },
      ];
    }
    // 再插入新笔记到列表顶部（若无分类，默认归入“学习”）
    if (params && params.newNote) {
      const nn = { ...params.newNote };
      nn.category = nn.category ?? '学习';
      this.notes = [nn, ...this.notes];
    }
  }
  
  formatDate(d: Date): string {
    const pad = (n: number) => (n < 10 ? '0' + n : n.toString());
    return `${pad(d.getMonth() + 1)}月${pad(d.getDate())}日 ${pad(d.getHours())}:${pad(d.getMinutes())}`;
  }
  handleDelete(index: number) {
    promptAction.showDialog({
      title: '删除确认',
      message: '确定删除该笔记吗？',
      buttons: [ { text: '取消', color: '#5F6368' }, { text: '删除', color: '#D93025' } ]
    }).then((data) => {
      if (data.index === 1) {
        this.notes = this.notes.filter((_: any, i: number) => i !== index)
      }
    })
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

      // 搜索栏（位于分类器上方）
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
      .margin({ top: 16, bottom: 8 })
      .alignSelf(ItemAlign.Center)

      // 分类/导航：全部 学习 导航栏
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
              ForEach(this.notes.filter((n: any) => (this.selectedCategory === '全部' || n.category === this.selectedCategory) && (this.keyword.trim() === '' || (n.title?.includes(this.keyword) || n.content?.includes(this.keyword)))), (note: any, index: number) => {
                Column() {
                  Row() {
                    Text(note.title || '无标题')
                      .fontSize(18)
                      .fontWeight(FontWeight.Bold)
                      .layoutWeight(1)
                    if (note.category) {
                      Text(note.category)
                        .fontSize(12)
                        .fontColor(note.category === '学习' ? '#1967D2' : '#137333')
                        .backgroundColor(note.category === '学习' ? '#E8F0FE' : '#E6F4EA')
                        .borderRadius(12)
                        .padding({ left: 10, right: 10, top: 4, bottom: 4 })
                    }
                  }
                  .width('100%')
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
                .onTouch((event: TouchEvent) => {
                  if (event.type === TouchType.Down) {
                    if (this.longPressTimer !== -1) { clearTimeout(this.longPressTimer); this.longPressTimer = -1 }
                    this.longPressTimer = setTimeout(() => {
                      this.longPressTimer = -1
                      this.longPressTriggered = true
                      this.handleDelete(index)
                    }, 600)
                  } else if (event.type === TouchType.Up || event.type === TouchType.Cancel) {
                    if (this.longPressTimer !== -1) { clearTimeout(this.longPressTimer); this.longPressTimer = -1 }
                  }
                })
                .onClick(() => {
                  if (this.longPressTriggered) { this.longPressTriggered = false; return }
                  router.pushUrl({ url: 'pages/NoteDetail', params: { note } })
                })
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
             .margin({ right: 28, bottom: 25 })
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
      .border({ width: 0.5, color: '#EEEEEE' })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}