# Локальный движок Aurora AI Hub

Для [Issue #9](https://github.com/liquoree/aurora-ai-hub/issues/9) используем CPU-версию `llama-server`. Исходники движка собираются отдельно от Qt-приложения. Версия — [llama.cpp v1.0.0, коммит b1b770d90d94cad9e9ea5b993bdbc383a522fb28](https://github.com/ggml-org/llama.cpp/commit/b1b770d90d94cad9e9ea5b993bdbc383a522fb28).

## Подготовка исходников

В отдельном рабочем каталоге, доступном сборочной среде, выполните:

```sh
git clone --depth 1 --branch v1.0.0 https://github.com/ggml-org/llama.cpp.git
cd llama.cpp
test "$(git rev-parse HEAD)" = b1b770d90d94cad9e9ea5b993bdbc383a522fb28
```

## Сборка для Aurora OS 5.2.1.200 x86_64

В Build Engine MB2 найдите цель 5.2.1.200 x86_64 командой `sdk-manage target list`, войдите в неё через `sb2 -t ИМЯ_ЦЕЛИ` и перейдите в каталог исходников. Ниже приведена конфигурация для проверки в MB2.

```sh
cmake -S . -B build-aurora -G Ninja \
  -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=OFF \
  -DGGML_NATIVE=OFF -DGGML_AVX=OFF -DGGML_AVX2=OFF \
  -DGGML_FMA=OFF -DGGML_F16C=OFF -DGGML_OPENMP=OFF \
  -DLLAMA_OPENSSL=OFF -DLLAMA_BUILD_UI=OFF -DLLAMA_USE_PREBUILT_UI=OFF \
  -DLLAMA_BUILD_TESTS=OFF -DLLAMA_BUILD_EXAMPLES=OFF \
  -DLLAMA_BUILD_APP=OFF -DLLAMA_BUILD_SERVER=ON
cmake --build build-aurora --target llama-server --parallel 4
file build-aurora/bin/llama-server
readelf -h build-aurora/bin/llama-server
```

Ожидаемый артефакт — исполняемый ELF64 для x86-64. Для проверки кросс-сборки в контейнере `aurora-build-tools:5.2.1.200` к команде конфигурации добавляется `-DCMAKE_TOOLCHAIN_FILE=/usr/share/cmake/toolchain/x86_64-meego-linux-gnu-g++.cmake`. Для каждого комплекта используйте отдельный каталог сборки.

## Проверка генерации в эмуляторе

Использована модель [stories260K.gguf](https://huggingface.co/ggml-org/tiny-llamas/blob/def3e2dd70df35ecbf6403ea347de4c5977220c1/stories260K.gguf) с SHA-256 `047bf46455a544931cff6fef14d7910154c56afbc23ab1c5e56a72e69912c04b`. Скопируйте модель и бинарник соответствующей архитектуры в один каталог эмулятора.

В эмуляторе запустите сервер:

```sh
./llama-server -m stories260K.gguf -c 256 -t 2 -ngl 0 --host 127.0.0.1 --port 19090
```

В другой сессии эмулятора выполните запросы:

```sh
curl -fsS http://127.0.0.1:19090/health
curl -fsS -H 'Content-Type: application/json' \
  -d '{"prompt":"Once upon a time","n_predict":12,"temperature":0,"seed":42}' \
  http://127.0.0.1:19090/completion
```

На Aurora OS 5.2.1.200 ARM64 оба запроса вернули HTTP 200. Ответ проверки готовности — `{"status":"ok"}`. Ответ модели — `, there was a little girl named Lily. She` (`tokens_predicted: 12`).

ARM64-бинарник собран в Aurora BT 5.2.1.200 с `-DCMAKE_TOOLCHAIN_FILE=/usr/share/cmake/toolchain/aarch64-meego-linux-gnu-g++.cmake`, `-DCMAKE_AR=/usr/bin/ar` и `-DCMAKE_RANLIB=/usr/bin/ranlib`. Флаги AVX, AVX2, FMA и F16C относятся к x86_64.
