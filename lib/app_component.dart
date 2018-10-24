import 'dart:async';
import 'package:angular/angular.dart';
import 'package:langcab_ui/src/login/auth_service.dart';
import 'package:langcab_ui/src/language/language_service.dart';
import 'package:langcab_ui/src/message/message_component.dart';
import 'package:langcab_ui/src/message/message_service.dart';
import 'package:langcab_ui/src/words/word_service.dart';
import 'package:langcab_ui/src/study/word_study_service.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_router/angular_router.dart';

@Component(
  selector: 'my-app',
  templateUrl: 'app_component.html',
  styleUrls: [
    'app_component.scss.css',
    'package:angular_components/app_layout/layout.scss.css',
  ],
  directives: const [
    routerDirectives,
    coreDirectives,
    formDirectives,
    materialDirectives,
    ButtonDirective,
    DeferredContentDirective,
    MaterialButtonComponent,
    MaterialIconComponent,
    MaterialPersistentDrawerDirective,
    MaterialTemporaryDrawerComponent,
    ModalComponent,
    MaterialToggleComponent,
    MessageComponent
  ],

  providers: [WordService, StudyService, LanguageService, AuthService, MessageService, materialProviders],
)

class AppComponent {

  final AuthService authService;
  final centeredTabLabels = const <String>['Sign in', 'Sign up'];
  bool showSignInDialog = false;
  bool showAutoDismissDialog = false;
  bool showPassword = false;
  bool register = false;
  int tabIndex = 0;
  String type = 'password';
  String email;
  String password;

  AppComponent(AuthService this.authService);

  togglePW() {
    if (showPassword = false)
      type = 'password';
    else type = 'text';
  }

  proceed() {
    if (register)
      signUpEmail();
    else
      signInEmail();
  }

  Future<Null> clickTab() async {
    switch(tabIndex) {
      case 0:
        register = false;
        break;
      case 1:
        register = true;
    }
  }

  Future<Null> signInEmail() async {
    authService.emailSignIn(email, password);
    email = "";
    password = "";
    showSignInDialog = false;
    await authService.getToken();
  }

  Future<Null> signUpEmail() async {
    try {
      authService.emailSignUp(email, password);
      email = "";
      password = "";
      showSignInDialog = false;
      showAutoDismissDialog = true;
    } catch (e) {
      print('error $e');
    }
  }

  Future<Null> dismissDialog() async {
    showAutoDismissDialog = false;
    register = false;
    tabIndex = 0;
    showSignInDialog = true;
  }
}