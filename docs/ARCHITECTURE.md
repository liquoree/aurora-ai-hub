# Aurora AI Hub architecture

- `qml/modules/`: feature-based UI modules; each page uses Sailfish Silica.
- `qml/shared/`: UI components shared between features.
- `src/modules/`: C++ ViewModels exposing state and actions to QML.
- `src/bootstrap/`: service initialization and QML bindings.
- `core/`: model storage, runtime lifecycle, inference client.
- `integrations/dbus/`: D-Bus adapter for other applications.
- `sdk/qt/`: public client library for third-party applications.
- `examples/`: independent demonstration applications.

Dependency direction: QML -> ViewModel -> core services -> Qt/platform integration.
Features should not import another feature's private implementation.
Keep the Aurora SDK generated packaging, desktop file, translations and icons.
Do not add runtime or D-Bus capabilities before validating them on a device.
