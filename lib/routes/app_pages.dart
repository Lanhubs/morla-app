import 'package:get/get.dart';
import 'package:morla/features/clients/views/clients_view.dart';
import 'package:morla/features/new_invoice/views/new_invoice_view.dart';
import 'package:morla/features/new_invoice/bindings/new_invoice_binding.dart';
import 'package:morla/features/payment-setup/binding/payment_setup_binding.dart';
import 'package:morla/features/payment-setup/view/payment_setup_view.dart';
import 'package:morla/features/settlement_methods/view/settlement_methods_view.dart';
import 'package:morla/routes/app_routes.dart';
import 'imports.dart';

class AppPages {
  static List<GetPage> get pages => [
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeView(),
      binding: HomeBindings(),
    ),
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(name: AppRoutes.onboarding, page: () => const OnboardingView()),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.signup,
      page: () => const SignUpView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: AppRoutes.finalStep,
      page: () => const SignFinalStepView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: AppRoutes.verify,
      page: () => const VerifyEmailEmailView(),
      binding: VerifyBinding(),
    ),
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.newClient,
      page: () => const NewClientView(),
      binding: NewClientBinding(),
    ),
    GetPage(
      name: AppRoutes.clients,
      page: () => const ClientsView(),
      binding: ClientsBinding(),
    ),
    GetPage(
      name: AppRoutes.invoiceDetails,
      page: () => const InvoiceDetailsView(),
      binding: InvoiceDetailsBindings(),
    ),
    GetPage(name: AppRoutes.invoices, page: () => const InvoicesView()),
    GetPage(
      name: AppRoutes.newInvoice,
      page: () => const NewInvoiceView(),
      binding: NewInvoiceBinding(),
    ),
    GetPage(
      name: AppRoutes.forgotPasswordEmail,
      page: () => const ForgotPasswordEmailView(),
      binding: ForgotPasswordEmailBinding(),
    ),
    GetPage(
      name: AppRoutes.forgotPasswordVerify,
      page: () => const ForgotPasswordOtpView(),
      binding: ForgotPasswordOtpBinding(),
    ),
    GetPage(
      name: AppRoutes.forgotPasswordReset,
      page: () => const ForgotPasswordResetView(),
      binding: ForgotPasswordResetBinding(),
    ),
    GetPage(
      name: AppRoutes.paymentSetup,
      page: () => const PaymentSetupView(),
      binding: PaymentSetupBindings(),
    ),
    GetPage(
      name: AppRoutes.settlementMethods,
      page: () => SettlementMethodsPage(),
    ),
  ];
}
