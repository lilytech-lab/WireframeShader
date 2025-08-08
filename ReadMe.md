# WireframeShader

[![openupm](https://img.shields.io/npm/v/com.lilytech-lab.wireframe-shader?label=openupm&registry_uri=https://package.openupm.com)](https://openupm.com/packages/com.lilytech-lab.wireframe-shader/)
  [![Sponsor me on GitHub](https://img.shields.io/badge/Sponsor-❤️-ff69b4)](https://github.com/sponsors/lilytech-lab)  

[日本語版ReadMeはこちら](ReadMe_ja.md)

A Unity URP shader that colors the edges of polygons.

![UsingImage](https://github.com/user-attachments/assets/01ebf94a-2802-4423-b88e-b3d48ba573e4)

<!-- @import "[TOC]" {cmd="toc" depthFrom=2 depthTo=6 orderedList=false} -->

<!-- code_chunk_output -->

- [📦 Installation](#-installation)
  - [Unity Package Manager](#unity-package-manager)
  - [Open UPM](#open-upm)
  - [Manual Download](#manual-download)
- [⚙️ Settings](#️-settings)
  - [Wireframe](#wireframe)
  - [Other Settings](#other-settings)
- [🔖 Tested Unity Versions](#-tested-unity-versions)
- [📗 Reference Article](#-reference-article)
- [👥 Help & Contribute](#-help--contribute)
- [🏢 Author Info](#-author-info)
- [📄 License](#-license)

<!-- /code_chunk_output -->

## 📦 Installation

### Unity Package Manager

In the Package Manager, select "Install package from git URL" and enter "[https://github.com/lilytech-lab/WireframeShader.git](https://github.com/lilytech-lab/WireframeShader.git)" in the URL field.

### Open UPM

This package is also available on [Open UPM](https://openupm.com/packages/com.lilytech-lab.wireframe-shader/).

```sh
openupm add com.lilytech-lab.wireframe-shader
```

### Manual Download

Download from [Releases](https://github.com/lilytech-lab/WireframeShader/releases).

## ⚙️ Settings

To apply the shader, select Custom/Wireframe in the material's shader seelction dropdown.

### Wireframe

- **Wireframe Width**: Thickness of the wireframe lines.
- **Wireframe Color**: Color of the wireframe. Setting it to transparent makes the wireframe areas see-through.
- **Wireframe Emission Color**: Emission color that can be applied to the wireframe.

### Other Settings

Same as the standard Lit shader.

## 🔖 Tested Unity Versions

This shader has been tested on the following Unity versions:
- 2022.3.37f1
- 6000.0.29f1

## 📗 Reference Article

We wrote about the key points of the source code in this article (Japanese):
- [【Unity】ワイヤーフレームシェーダー](https://qiita.com/masamin/items/142b99f139635d19341a)

## 👥 Help & Contribute

If you have ideas for improvements, we would appreciate pull requests.

## 🏢 Author Info

Lilytech Lab, Ltd.  
https://www.lilytech-lab.com/  
[https://github.com/lilytech-lab](https://github.com/lilytech-lab)

A small IT engineering company base in Osaka, Japan.

If you find this project helpful, I would greatly appreciate your support [here](https://github.com/sponsors/lilytech-lab).

## 📄 License

MIT License
