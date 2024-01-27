# VSCode+DockerによるAtCoder用C++/Python環境設定

詳しくは[こちらのブログ](https://miiitomi.github.io/p/kyopro-env/)をご覧ください．

## ディレクトリ構成

```sh
.
├── .devcontainer
│   └── devcontainer.json      # Container設定
├── .vscode
│   ├── c_cpp_properties.json  # C/C++ extension設定
│   ├── cpp.code-snippets      # C++スニペット
│   ├── launch.json            # デバッグ設定
│   ├── python.code-snippets   # Pythonスニペット
│   ├── settings.json          # ワークスペース（特にcode-runner）設定
│   └── tasks.json             # タスク設定
├── ABC
│   └── abc336                 # 例
│       ├── a.cpp
│       ├── a.py
│       └── input.txt          # 手動実行・デバッグ時用入力ファイル
├── Dockerfile                 # Docker設定
├── ac-library                 # Atcoder Library
│   └── ...
├── requirements.txt           # pip用requirements（特にonline-judge-tools）
├── submit.sh                  # 自動提出用スクリプト
└── test.sh                    # 自動テスト用スクリプト
```

## VSCodeからdocker containerで開くまで

このディレクトリを，VSCodeで開いてください．

また，VSCodeで「Dev Containers」の拡張機能をインストールしていない場合は，左のツールバーから拡張機能を開き，検索してこちらをインストールしてください（これ↓）
![](/images/kyopro-env/devcontainers.png)

Dockerを起動していることを確認した上で，左したの「><」みたいなボタンから「コンテナーで再度開く（Reopen in Container）」を選択して，コンテナーで開いてください（初めての場合はビルドに少し時間がかかります）．
![](/images/kyopro-env/open_container.png)


## 最初のセットアップ

開けたら，最初のセットアップを少しだけ行います．

1. ターミナルを開き（上部のツールバーから，またはMacの場合は`ctl+Shift+^`），以下のコマンドで online-judge-tools（oj）からatcoderにログインしてください（`{USERNAME}`と`{PASSWORD}`は自身のatcoderのユーザ名・パスワードで）．
    ```sh
    oj login https://atcoder.jp -u {USERNAME} -p {PASSWORD}
    ```
    `[SUCCESS] You have already signed in.` のように出たら成功です．
2. (optional) git/githubを用いる場合はssh keyの作成と公開鍵の登録などしとくとcontainerからもgithubにアクセスできて便利です．


## 使い方
### 手動実行
例にある通り，`./ABC/abc336/` のようにコンテストごとにディレクトリを作り，問題Aに対しては `a.cpp` や `a.py` のようにファイルを作成してください．実行コードを書き，また `input.txt` に与えたい入力を書き込みます．

実行コードファイルを開いた状態で右上から「Run Code」を押す（またはMacの場合「option+ctl+N」）と，ターミナルが開き実行されます．

![](/images/kyopro-env/runcode.png)

### 自動テスト
同様に実行コードを書き，上のツールバーのターミナルから「タスクを実行」を選択（または`cmd+shift+P`から`タスクを実行`）し，「test」を押すと，以下のようにojを用いて自動でサンプルケースをダウンロードして実行してくれます（以下はサンプルについてACだったときの例）．

![](/images/kyopro-env/test.png)

もしかしたら実行時に `Permission denied` のようにエラーを吐くかもしれませんが，その場合はターミナルを開いて `chhmod +x test.sh` のようにして実行権限を付与してください．

### 自動提出
テストと同様に「タスクを実行」から「submit」を実行すると，ojを用いてatcoderにsubmitされ，ブラウザが開いてsubmission pageが開かれます．
C++なら「C++ 23 (gcc 12.2)」，Pythonなら「Python (PyPy 3.10-v7.3.12)」で提出されると思います．

### デバッグ
実行ファイルと入力ファイルの`input.txt`を手動実行と同様に同階層に置きます．
実行ファイルの行番号の横の空白の上にカーソルを合わせると薄く赤丸が現れるので，デバッグ時に止めたい箇所で押してブレークポイントを置きます．
左のツールバーから虫付きの▷のようなマークを押し，上部からPythonなら「Python Debug」を，C++なら「(lldb) C++ Debug」を選択して「▷」を押すとデバッグ実行がされます．
![](/images/kyopro-env/debug.png)
上部の「▷」を押してブレークポイントを一つずつ進めながら，左のバーやデバッグコンソールから変数を確認することができます．
