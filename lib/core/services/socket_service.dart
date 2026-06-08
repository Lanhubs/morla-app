import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:billkit/core/services/auth_token_storage_service.dart';

class SocketService extends GetxService {
  io.Socket? _socket;
  final RxBool isConnected = false.obs;
  final RxInt reconnectAttempts = 0.obs;
  final AuthTokenStorageService _tokenStorage = const AuthTokenStorageService();

  static const String _apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://10.0.2.2:3000',
  );

  static const int _maxReconnectAttempts = 5;

  Future<SocketService> init() async {
    await _initializeSocket();
    return this;
  }

  Future<void> _initializeSocket() async {
    try {
      final token = await _tokenStorage.getToken();

      if (token == null || token.isEmpty) {
        print('⚠️ No token found, skipping socket connection');
        return;
      }

      _socket = io.io(
        _apiBaseUrl,
        io.OptionBuilder()
            .setTransports(['websocket'])
            .enableAutoConnect()
            .enableReconnection()
            .setReconnectionDelay(2000)
            .setReconnectionDelayMax(10000)
            .setReconnectionAttempts(_maxReconnectAttempts)
            .setAuth({'token': token})
            .build(),
      );

      _setupEventListeners();
      _socket?.connect();

      print('🔌 Socket service initialized');
    } catch (e) {
      print('❌ Socket initialization error: $e');
    }
  }

  void _setupEventListeners() {
    _socket?.onConnect((_) {
      print('✅ Socket connected');
      isConnected.value = true;
      reconnectAttempts.value = 0;
    });

    _socket?.onDisconnect((_) {
      print('⚠️ Socket disconnected');
      isConnected.value = false;
    });

    _socket?.onConnectError((error) {
      print('❌ Socket connection error: $error');
      isConnected.value = false;
    });

    _socket?.onError((error) {
      print('❌ Socket error: $error');
    });

    _socket?.onReconnectAttempt((attemptNumber) {
      print('🔄 Socket reconnect attempt: $attemptNumber');
      reconnectAttempts.value = attemptNumber as int;
    });

    _socket?.onReconnect((_) {
      print('✅ Socket reconnected');
      isConnected.value = true;
      reconnectAttempts.value = 0;
    });

    _socket?.onReconnectFailed((_) {
      print(
        '❌ Socket reconnection failed after $_maxReconnectAttempts attempts',
      );
      isConnected.value = false;
    });

    // Handle ping/pong for connection health
    _socket?.on('pong', (_) {
      // Connection is healthy
    });
  }

  /// Listen for new announcements
  void onAnnouncementReceived(Function(Map<String, dynamic>) callback) {
    _socket?.on('announcement:new', (data) {
      print('📢 New announcement received: $data');
      if (data is Map<String, dynamic>) {
        callback(data);
      }
    });
  }

  /// Send ping to check connection
  void ping() {
    _socket?.emit('ping');
  }

  /// Manually reconnect
  Future<void> reconnect() async {
    if (_socket == null) {
      await _initializeSocket();
    } else {
      _socket?.connect();
    }
  }

  /// Disconnect socket
  void disconnect() {
    _socket?.disconnect();
    isConnected.value = false;
  }

  @override
  void onClose() {
    disconnect();
    _socket?.dispose();
    super.onClose();
  }
}
