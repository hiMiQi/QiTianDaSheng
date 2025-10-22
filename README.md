# 小栖云 RestCloud 开发文档

## 项目概览
- 名称：小栖云 RestCloud（HarmonyOS / ArkTS）
- 目标：提供笔记、菜谱、待办与个人中心的轻量化体验，强调简单直观的交互与快速响应
- 技术栈：ArkTS、HarmonyOS UI、DevEco Studio、Hvigor 构建
- 根目录：`c:\Users\white\DevEcoStudioProjects\FanQue`

## 环境准备
- 安装 DevEco Studio（含 HarmonyOS SDK 与 ArkTS 插件）
- Windows 终端可直接使用项目自带脚本：`./hvigorw.bat`
- 推荐启用真机或最新模拟器以获取更真实的性能与渲染行为

## 目录结构
- 页面代码：`entry/src/main/ets/pages/`
  - `Index.ets` 首页与底部导航
  - `Mine.ets` 我的中心（登录信息、设置、退出）
  - `Login.ets` 登录页（账号密码输入、登录/跳过）
  - 其他页面：`Recipe.ets`、`Todo.ets`（如存在）
- 资源：`entry/src/main/resources/base/media/`
  - 图标示例：`mine.png`、`mine_active.png`、`cai.png`、`cai_active.png`、`daiban.png`、`daiban_active.png` 等
- 构建配置：
  - `hvigorw.bat`（Windows 构建入口）
  - `hvigorfile.ts`（模块构建配置）
  - `build-profile.json5`（构建与签名配置）

## 运行与构建
- 构建 HAP：
  ```
  ./hvigorw.bat assembleHap -p entry
  ```
- 常见提示：若未配置签名，会显示跳过签名的警告；正式打包需在 `build-profile.json5` 配置 `signingConfigs`
- 运行：DevEco Studio 选择模拟器或真机，直接点击运行即可

## 路由与导航
- API：`@ohos.router`
  - 保留栈：`router.pushUrl({ url: 'pages/XXX' })`
  - 替换栈：`router.replaceUrl({ url: 'pages/XXX' })`
- 页面示例：
  - 首页底部“我的”入口：`Index.ets` → `router.pushUrl({ url: 'pages/Mine' })`
  - 我的页底部导航（当前页高亮）：图标 `mine_active.png`，文字颜色 `'#36C7F3'`

## 状态管理（会话内）
- 会话内持久：`AppStorage` + `@StorageLink`
  - 声明：`@StorageLink('loggedIn') loggedIn: boolean = false`
  - 更新：
    - 登录成功：`AppStorage.SetOrCreate('loggedIn', true)`
    - 退出登录：`AppStorage.SetOrCreate('loggedIn', false)`
- 页面对应：
  - `Index.ets` 与 `Mine.ets` 使用 `@StorageLink('loggedIn')`，不再依赖路由参数
  - `Login.ets` 登录成功后设置 `loggedIn=true` 并返回首页；跳过登录则写入 `false`

## 登录与退出流程
- 登录页凭据：示例为 `admin/admin`
- 登录成功：
  ```ts
  if (acc === 'admin' && pwd === 'admin') {
    AppStorage.SetOrCreate('loggedIn', true);
    router.replaceUrl({ url: 'pages/Index' });
  }
  ```
- 跳过登录：
  ```ts
  AppStorage.SetOrCreate('loggedIn', false);
  router.replaceUrl({ url: 'pages/Index' });
  ```
- 我的页退出：
  ```ts
  AppStorage.SetOrCreate('loggedIn', false);
  router.replaceUrl({ url: 'pages/Login' });
  ```

## 资源与样式规范
- 资源引用：`$r('app.media.xxx')`
- 底部导航激活态：当前页面使用 `*_active.png` 与主色文字 `'#36C7F3'`
- 常用颜色：
  - 主色：`'#36C7F3'`
  - 文本：深色 `'#333333'`、次级 `'#999999'`、白色 `'#FFFFFF'`
  - 分割线：`'#EEEEEE'`
- 渐变示例（登录按钮）：
  ```ts
  .linearGradient({ angle: 12, colors: [['#0097FF', 0.0], ['#00C4FF', 0.5], ['#2EE6A6', 1.0]] })
  ```

## 组件封装建议
- 底部导航组件化：抽象为 `BottomTabBar`，接收 `activeTab` 与点击回调，减少各页重复代码
- 列表项组件化：`SettingItem`（标题、右箭头、点击回调），保证统一高度与分割线
- 信息卡组件化：`UserInfoCard`（头像、昵称、ID、顶部背景），便于复用与统一样式

## 数据持久化（可选增强）
- 目标：重启后仍记住登录状态与基础偏好
- 方案：`@ohos.data.preferences`
  - 写入示例：
    ```ts
    import preferences from '@ohos.data.preferences';
    // 获取或创建偏好
    const prefs = await preferences.getPreferences(getContext(this), 'app_prefs');
    await prefs.put('loggedIn', true);
    await prefs.flush();
    ```
  - 读取同步到 `AppStorage`：应用启动或首页 `aboutToAppear` 时读取并 `AppStorage.SetOrCreate('loggedIn', value)`

## 错误处理与用户反馈
- 弹窗：`promptAction.showDialog({ title, message, buttons })`
- Toast：`promptAction.showToast({ message })`
- 规范：
  - 登录失败用弹窗，表述清晰；按钮高亮色与主色一致
  - 列表项未完成功能用 Toast 提示“开发中”

## 性能优化要点
- 列表渲染：长列表使用 `List`/`LazyForEach` 代替大量 `Column`
- 图片与资源：确保尺寸合理，避免过大导致布局抖动
- 渲染层级：控制嵌套深度，统一使用边距与对齐而非多层容器
- 交互反馈：Toast/弹窗避免频繁触发，必要时做节流

## 测试清单
- 登录流程：`admin/admin` → 首页 → “我的”显示用户信息
- 会话持久：返回首页再进入“我的”，保持登录态
- 退出流程：点击“退出登录”→ 跳转登录页 → 再次进入“我的”，显示未登录视图
- 底部导航：当前页面图标为 `*_active.png` 且文字为主色
- 资源完整性：`media` 目录下必须存在所用图标资源

## 发布打包
- 配置签名：在 `build-profile.json5` 添加 `signingConfigs` 并关联到 `buildMode`
- 构建发布包：`./hvigorw.bat assembleHap -p entry`
- 真机安装：通过 DevEco Studio 或命令行安装 HAP

## 代码风格与规范
- 命名：组件大驼峰（`Login`、`Mine`）；状态小驼峰（`loggedIn`）
- 布局：合理使用 `padding`/`margin`/`alignItems`/`justifyContent`/`layoutWeight`
- 路由：减少跨页参数耦合，优先使用 `AppStorage` 共享
- 资源命名：`xxx.png` 与 `xxx_active.png` 成对出现，保持语义清晰

## 常见问题
- 图标未高亮：确认当前页底部图标是否使用 `*_active.png`，文字是否为主色
- 登录态丢失：检查是否从路由参数读写；应改为 `AppStorage` + `@StorageLink`
- 退出无反应：按钮 `onClick` 路由目标建议为 `pages/Login` 或返回首页并提示

## 后续规划
- 偏好/数据库持久化（`preferences` / `@ohos.data.rdb`）
- 网络接口与数据同步协议设计
- 底部导航与信息卡组件抽象与统一主题支持
- 暗色模式与高对比度适配，提高可访问性