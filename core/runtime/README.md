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
