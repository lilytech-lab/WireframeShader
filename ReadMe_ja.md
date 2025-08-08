# Wireframe Shader

[README in English](ReadMe.md)

ポリゴンのワイヤーフレーム部分を着色するUnity URP用シェーダーです。

![UsingImage](https://github.com/user-attachments/assets/01ebf94a-2802-4423-b88e-b3d48ba573e4)

<!-- @import "[TOC]" {cmd="toc" depthFrom=2 depthTo=6 orderedList=false} -->

<!-- code_chunk_output -->

- [📦 インストール方法](#-インストール方法)
  - [Unity Package Manager](#unity-package-manager)
  - [Open UPM](#open-upm)
  - [ファイルダウンロード](#ファイルダウンロード)
- [⚙️ 設定項目](#️-設定項目)
  - [Wierframe](#wierframe)
  - [その他の項目](#その他の項目)
- [🔖 動作確認バージョン](#-動作確認バージョン)
- [📗 参考記事](#-参考記事)
- [👥 Help & Contribute](#-help--contribute)
- [🏢 Author Info](#-author-info)
- [📄 License](#-license)

<!-- /code_chunk_output -->

## 📦 インストール方法

### Unity Package Manager

PackageManagerにて「Install package from git URL」を選択し、URL欄に "[https://github.com/lilytech-lab/WireframeShader.git](https://github.com/lilytech-lab/WireframeShader.git)" と入力してください。

### Open UPM

[Open UPM](https://openupm.com/packages/com.lilytech-lab.wireframe_shader/) にも対応しています。

```sh
openupm add com.lilytech-lab.wireframe-shader
```

### ファイルダウンロード

[Releases](https://github.com/lilytech-lab/WirefremeShader/releases) からダウンロードが可能です。

## ⚙️ 設定項目

### Wierframe

- Wireframe Width: ワイヤーフレームの太さ。
- Wireframe Color: ワイヤーフレーの色。透明にするとワイヤーフレーム部分が透けるようになります。
- Wireframe Emission Color: ワイヤーフレームにEmissionを指定することができます。

### その他の項目

Litシェーダーと同じです。

## 🔖 動作確認バージョン

下記のUnityのバージョンで動作確認しました。

- 2020.3.5f1
- 6000.0.29f1

## 📗 参考記事

下記の記事にソースコードのポイントなどを記しました。

- [【Unity】ワイヤーフレームシェーダー](https://qiita.com/masamin/items/142b99f139635d19341a)

## 👥 Help & Contribute

改善案を思い付いた方はPullRequestでお知らせいただけるとありがたいです。

## 🏢 Author Info

有限会社リリテックラボ  
[https://github.com/lilytech-lab](https://github.com/lilytech-lab)

大阪で小規模なITエンジニアリングを行っています。

## 📄 License

MITライセンス

