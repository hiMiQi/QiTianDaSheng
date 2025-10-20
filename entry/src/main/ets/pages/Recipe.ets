import router from '@ohos.router'
import http from '@ohos.net.http'
import image from '@ohos.multimedia.image'

@Entry
@Component
struct Recipe {
  @State activeTab: string = 'dessert'
  @State imageErrorMap: Record<number, boolean> = {}
  @State pixelMapMap: Record<number, any> = {}
  @State errorInfoMap: Record<number, string> = {}
  desserts: Array<any> = [
      { title: '提拉米苏', img: 'https://images.unsplash.com/photo-1541976076758-3c0b0e75f3ef?w=400&h=300&fit=crop' },
      { title: '草莓蛋糕', img: 'https://images.unsplash.com/photo-1483691278017-0d0a89af3979?w=400&h=300&fit=crop' },
      { title: '冰淇淋', img: 'https://images.unsplash.com/photo-1514517469759-9d3aa2038d6c?w=400&h=300&fit=crop' },
      { title: '马卡龙', img: 'https://images.unsplash.com/photo-1505250469679-203ad9ced0cb?w=400&h=300&fit=crop' },
      { title: '甜甜圈', img: 'https://images.unsplash.com/photo-1517242027095-2b2bd5a1f543?w=400&h=300&fit=crop' },
      { title: '布朗尼', img: 'https://images.unsplash.com/photo-1589190373016-9f94724aa3a0?w=400&h=300&fit=crop' },
    ]
    foods: Array<any> = [
      { title: '牛排', img: 'https://images.unsplash.com/photo-1550547660-d9450f859349?w=400&h=300&fit=crop' },
      { title: '汉堡', img: 'https://images.unsplash.com/photo-1551782450-a2132b4ba21d?w=400&h=300&fit=crop' },
      { title: '寿司', img: 'https://images.unsplash.com/photo-1546069901-eacef0df6022?w=400&h=300&fit=crop' },
      { title: '沙拉', img: 'https://images.unsplash.com/photo-1525755662778-989d0524087e?w=400&h=300&fit=crop' },
      { title: '意面', img: 'https://images.unsplash.com/photo-1523983300643-94feda3b86b8?w=400&h=300&fit=crop' },
      { title: '披萨', img: 'https://images.unsplash.com/photo-1548365328-5b2d9300da47?w=400&h=300&fit=crop' },
    ]

  getItems(): Array<any> {
    return this.activeTab === 'dessert' ? this.desserts : this.foods
  }

  build() {
    Column() {
      // 顶部标题和返回
      Row() {
        Row() {
          Text('←')
            .fontSize(22)
            .fontColor('#444444')
        }
        .width(44)
        .height(44)
        .onClick(() => { router.back() })

        Text('菜谱')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor('#222222')

        Row() {}
        .width(44)
        .height(44)
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .justifyContent(FlexAlign.SpaceBetween)
      .border({ width: 0.5, color: '#EEEEEE' })

      // 分类标签：甜点 / 美食
      Row() {
        Text('甜点')
          .fontSize(16)
          .fontColor(this.activeTab === 'dessert' ? '#000000' : '#777777')
          .fontWeight(this.activeTab === 'dessert' ? FontWeight.Bold : FontWeight.Normal)
          .onClick(() => { this.activeTab = 'dessert' })
        Text('美食')
          .fontSize(16)
          .fontColor(this.activeTab === 'food' ? '#000000' : '#777777')
          .fontWeight(this.activeTab === 'food' ? FontWeight.Bold : FontWeight.Normal)
          .margin({ left: 24 })
          .onClick(() => { this.activeTab = 'food' })
      }
      .width('100%')
      .padding({ left: 20, right: 20, top: 12, bottom: 8 })

      // 列表
      Column() {
        ForEach(this.getItems(), (it: any, i: number) => {
          Column() {
            if (this.pixelMapMap[i]) {
              Image(this.pixelMapMap[i])
                .width('100%')
                .height(160)
                .objectFit(ImageFit.Cover)
                .borderRadius(10)
            } else if (this.imageErrorMap[i]) {
              Column() {
                Text(this.errorInfoMap[i] ? `图片加载失败 (${this.errorInfoMap[i]})` : '图片加载失败')
                  .fontSize(12)
                  .fontColor('#999999')
              }
              .width('100%')
              .height(160)
              .backgroundColor('#F3F4F6')
              .borderRadius(10)
              .alignItems(HorizontalAlign.Center)
              .justifyContent(FlexAlign.Center)
            } else {
              Column() {}
              .width('100%')
              .height(160)
              .backgroundColor('#F5F6F7')
              .borderRadius(10)
            }
            Text(it.title)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .margin({ top: 8 })
          }
          .width('100%')
          .backgroundColor('#FFFFFF')
          .border({ width: 0.5, color: '#EEEEEE' })
          .borderRadius(12)
          .padding({ left: 12, right: 12, top: 12, bottom: 12 })
          .margin({ left: 20, right: 20, bottom: 12 })
          .onAppear(() => { if (!this.pixelMapMap[i] && !this.imageErrorMap[i]) { this.loadImage(i, it.img) } })
        })
      }
      .width('100%')
      .layoutWeight(1)

      // 底部导航：笔记 / 菜谱 / 待办
      Row() {
        Column() {
          Image($r('app.media.wenjianjia'))
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
        .onClick(() => { router.replaceUrl({ url: 'pages/Todo' }) })
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
  async loadImage(idx: number, url: string) {
    const markError = (msg: string) => {
      this.imageErrorMap = { ...this.imageErrorMap, [idx]: true };
      this.errorInfoMap = { ...this.errorInfoMap, [idx]: msg };
    };

    const fetchPixelMap = async (targetUrl: string): Promise<any> => {
      const client = http.createHttp();
      try {
        const res = await client.request(targetUrl, {
          method: http.RequestMethod.GET,
          expectDataType: http.HttpDataType.ARRAY_BUFFER,
          readTimeout: 15000,
          connectTimeout: 10000,
          header: {
            'User-Agent': 'FanQue/1.0 (HarmonyOS ArkUI)',
            'Accept': 'image/*',
            'Referer': 'https://images.unsplash.com/'
          }
        });
        console.info(`Recipe image url=${targetUrl} code=${res.responseCode}`);
        const buf = (res && res.result) ? (res.result as ArrayBuffer) : undefined;
        if (!buf) { throw new Error('empty buffer'); }
        const src = image.createImageSource(buf);
        const pm = await new Promise<any>((resolve, reject) => {
          src.createPixelMap((err, out) => {
            if (err || !out) { reject(err || new Error('decode failed')); }
            else { resolve(out); }
          });
        });
        return pm;
      } finally {
        client.destroy();
      }
    };

    try {
      const pm = await fetchPixelMap(url);
      this.pixelMapMap = { ...this.pixelMapMap, [idx]: pm };
      this.errorInfoMap = { ...this.errorInfoMap, [idx]: '' };
    } catch (e1) {
      console.error(`primary image failed i=${idx} err=${e1}`);
      // 备用源1：HTTPS picsum
      const fallback1 = `https://picsum.photos/seed/fanque-${idx}/600/360`;
      try {
        const pm2 = await fetchPixelMap(fallback1);
        this.pixelMapMap = { ...this.pixelMapMap, [idx]: pm2 };
        this.errorInfoMap = { ...this.errorInfoMap, [idx]: '' };
        return;
      } catch (e2) {
        console.error(`fallback1 failed i=${idx} err=${e2}`);
      }
      // 备用源2：HTTP placekitten（用于判断是否为TLS证书问题）
      const fallback2 = `http://placekitten.com/600/360`;
      try {
        const pm3 = await fetchPixelMap(fallback2);
        this.pixelMapMap = { ...this.pixelMapMap, [idx]: pm3 };
        this.errorInfoMap = { ...this.errorInfoMap, [idx]: '' };
      } catch (e3) {
        console.error(`fallback2 failed i=${idx} err=${e3}`);
        markError('网络/证书受限');
      }
    }
  }
}