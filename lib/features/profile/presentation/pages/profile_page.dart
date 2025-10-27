import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../../core/utils/auth_utils.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF111827),
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (state is AuthAuthenticated) ...[
                  // User Profile Header
                  Center(
                    child: Column(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF3B82F6), Color(0xFF2563EB)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF3B82F6).withOpacity(0.3),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              '${state.user.firstName[0]}${state.user.lastName[0]}'
                                  .toUpperCase(),
                              style: const TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          '${state.user.firstName} ${state.user.lastName}',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF111827),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          state.user.email,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Authentication Status Badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFDCFCE7),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFF86EFAC),
                        width: 1,
                      ),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: Color(0xFF16A34A),
                          size: 20,
                        ),
                        SizedBox(width: 12),
                        Text(
                          'Authenticated',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF16A34A),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Token Information Section
                  _buildSectionTitle('Token Information'),
                  const SizedBox(height: 12),

                  _buildTokenCard(
                    'Access Token',
                    state.user.accessToken,
                    context,
                    const Color(0xFF3B82F6),
                  ),
                  const SizedBox(height: 12),

                  _buildTokenCard(
                    'Refresh Token',
                    state.user.refreshToken,
                    context,
                    const Color(0xFF8B5CF6),
                  ),
                  const SizedBox(height: 24),

                  // Token Expiry Information
                  _buildSectionTitle('Token Status'),
                  const SizedBox(height: 12),
                  _buildTokenExpiryInfo(),
                  const SizedBox(height: 24),

                  // Refresh Token Button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        context.read<AuthBloc>().add(RefreshTokenEvent());
                      },
                      icon: const Icon(Icons.refresh, size: 20),
                      label: const Text(
                        'Refresh Tokens',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.2,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3B82F6),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ] else if (state is AuthSkipped) ...[
                  // Guest Mode Section
                  Center(
                    child: Column(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF3F4F6),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Icon(
                            Icons.person_outline,
                            size: 50,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Guest User',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF111827),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Browsing as guest',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  const SizedBox(height: 24),
                ] else ...[
                  // Not Authenticated State
                  Center(
                    child: Column(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFEE2E2),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Icon(
                            Icons.person_off_outlined,
                            size: 50,
                            color: Color(0xFFDC2626),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Not Authenticated',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF111827),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Please sign in to continue',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEE2E2),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFFFCA5A5),
                        width: 1,
                      ),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.error_outline,
                          color: Color(0xFFDC2626),
                          size: 20,
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Authentication Required',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFDC2626),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ],

                // Logout/Reset Button
                if (state is AuthAuthenticated || state is AuthSkipped) ...[
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        _showLogoutDialog(context, state is AuthAuthenticated);
                      },
                      icon: Icon(
                        state is AuthAuthenticated ? Icons.logout : Icons.login,
                        size: 20,
                      ),
                      label: Text(
                        state is AuthAuthenticated ? 'Logout' : 'Login',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.2,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFFDC2626),
                        side: const BorderSide(
                          color: Color(0xFFDC2626),
                          width: 1.5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color(0xFF111827),
      ),
    );
  }

  Widget _buildTokenCard(
    String title,
    String token,
    BuildContext context,
    Color accentColor,
  ) {
    final truncatedToken = token.length > 30
        ? '${token.substring(0, 30)}...'
        : token;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: accentColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accentColor.withOpacity(0.2), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: accentColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(Icons.key, size: 16, color: accentColor),
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: accentColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[300]!, width: 1),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    truncatedToken,
                    style: const TextStyle(
                      fontSize: 13,
                      fontFamily: 'monospace',
                      color: Color(0xFF374151),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                InkWell(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: token));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Row(
                          children: [
                            const Icon(
                              Icons.check_circle,
                              color: Colors.white,
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Text('$title copied to clipboard'),
                          ],
                        ),
                        backgroundColor: const Color(0xFF16A34A),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(6),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: accentColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Icon(Icons.copy, size: 16, color: accentColor),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTokenExpiryInfo() {
    return FutureBuilder<Map<String, dynamic>?>(
      future: AuthUtils.getTokenInfo(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: const Color(0xFFF9FAFB),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: Color(0xFF3B82F6),
                ),
              ),
            ),
          );
        }

        final tokenInfo = snapshot.data;
        if (tokenInfo == null) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFFEE2E2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFFCA5A5), width: 1),
            ),
            child: const Row(
              children: [
                Icon(Icons.error_outline, color: Color(0xFFDC2626), size: 20),
                SizedBox(width: 12),
                Text(
                  'Unable to read token info',
                  style: TextStyle(fontSize: 14, color: Color(0xFFDC2626)),
                ),
              ],
            ),
          );
        }

        final isExpired = tokenInfo['isExpired'] as bool? ?? true;
        final expiryDate = tokenInfo['expiryDate'] as String?;
        final timeUntilExpiry = tokenInfo['timeUntilExpiry'] as int?;

        final statusColor = isExpired
            ? const Color(0xFFDC2626)
            : const Color(0xFF16A34A);
        final backgroundColor = isExpired
            ? const Color(0xFFFEE2E2)
            : const Color(0xFFDCFCE7);
        final borderColor = isExpired
            ? const Color(0xFFFCA5A5)
            : const Color(0xFF86EFAC);

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: borderColor, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    isExpired ? Icons.error : Icons.check_circle,
                    color: statusColor,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    isExpired ? 'Token Expired' : 'Token Valid',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: statusColor,
                    ),
                  ),
                ],
              ),
              if (expiryDate != null) ...[
                const SizedBox(height: 12),
                _buildInfoRow(
                  Icons.calendar_today,
                  'Expires',
                  _formatDateTime(DateTime.parse(expiryDate).toLocal()),
                ),
              ],
              if (timeUntilExpiry != null) ...[
                const SizedBox(height: 8),
                _buildInfoRow(
                  Icons.timer,
                  timeUntilExpiry > 0 ? 'Time remaining' : 'Expired',
                  timeUntilExpiry > 0
                      ? '${timeUntilExpiry} minutes'
                      : '${timeUntilExpiry.abs()} minutes ago',
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF374151),
            ),
          ),
        ),
      ],
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  void _showLogoutDialog(BuildContext context, bool isAuthenticated) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(
              isAuthenticated ? Icons.logout : Icons.login,
              color: const Color(0xFFDC2626),
            ),
            const SizedBox(width: 12),
            Text(
              isAuthenticated ? 'Logout' : 'Login',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        content: Text(
          isAuthenticated
              ? 'Are you sure you want to logout?'
              : 'Are you sure you want to login?',
          style: const TextStyle(fontSize: 15),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text(
              'Cancel',
              style: TextStyle(
                color: Color(0xFF6B7280),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              context.read<AuthBloc>().add(LogoutEvent());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFDC2626),
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              isAuthenticated ? 'Logout' : 'Login',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
