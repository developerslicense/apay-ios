## Техническая документация для интеграции sdk AirbaPay в мобильные приложения

## 1.1 Подключение sdk

## 1.2 Вызов стартовой формы

## 1.3 Пример использования

## 1.4 Подключение нативного ApplePay

## 1.5 Подключение АПИ внешнего взаимодействия с ApplePay (Нативный)

## 1.6 Подключение АПИ внешнего взаимодействия с ApplePay (Вебвью)

## 1.7 Рекомендация в случае интеграции в flutter

## 1.1  Подключение sdk

1) SPM -> GitHub - ```developerslicense/apay-ios```

2) Нужно добавить конфиги в ```info.plist```

```
KEY -> Privacy - Face ID Usage Description

TYPE -> String

VALUE -> “Запрос доступа к сохраненным картам”
```

```
KEY -> Privacy - Privacy - Camera Usage Description

TYPE -> String

VALUE -> “Предоставьте разрешение для использования сканнера банковских карт”
```

3) Нужно добавить ```import AirbaPay``` в файле ```App``` и в месте использования в приложении.
   В ```App``` нужно выполнить ```регистрацию шрифтов``` при инициализации.

```
@main
struct TestApp: App {
    init() {
        AirbaPayFonts.registerCustomFonts()
        ~~~
    }
```

Для инициализации sdk нужно выполнить ```AirbaPaySdk.initSdk()``` перед
вызовом ```AirbaPaySdk.startAirbaPay() ```.

| Параметр            | Тип                                  | Обязательный | Описание                                                                        |
|---------------------|--------------------------------------|--------------|---------------------------------------------------------------------------------|
| shopId              | String                               | да           | ID магазина в системе AirbaPay                                                  |
| password            | String                               | да           | Пароль в системе AirbaPay                                                       |
| terminalId          | String                               | да           | ID терминала под которым создали платеж                                         |
| accountId           | String                               | да           | ID аккаунта пользователя                                                        |
| lang                | AirbaPaySdk.Lang                     | да           | Код языка для UI                                                                |
| isProd              | Bool                                 | да           | Продовская или тестовая среда airbapay                                          |
| phone               | String                               | да           | Телефон пользователя                                                            |
| failureCallback     | String                               | да           | URL вебхука при ошибке                                                          |
| successCallback     | String                               | да           | URL вебхука при успехе                                                          |
| userEmail           | String                               | да           | Емейл пользователя, куда будет отправлена квитанция. В случае отсутствия емейла |
| colorBrandMain      | Color                                | нет          | Брендовый цвет кнопок, переключателей и текста                                  |
| colorBrandInversion | Color                                | нет          | Цвет текста у кнопок с брендовым цветом                                         |
| autoCharge          | Int                                  | нет          | Автоматическое подтверждение при 2х-стадийном режиме 0 - нет, 1 - да            |
| enabledLogsForProd  | Bool                                 | нет          | Флаг для включения логов                                                        |
| purchaseAmount      | Int                                  | да           | Сумма платежа                                                                   |
| invoiceId           | String                               | да           | ID платежа в системе магазина                                                   | 
| orderNumber         | String                               | да           | Номер заказа в системе магазина                                                 |
| goods               | Array<AirbaPaySdk.Goods>             | да           | Список продуктов для оплаты                                                     |
| settlementPayments  | Array<AirbaPaySdk.SettlementPayment> | нет          | Распределение платежа по компаниям. В случае одной компании, может быть nil     |
| shopName            | String                               | нет          | Название магазина для нативного ApplePay                                        |
| isApplePayNative    | Boolean                              | нет          | Флаг, определяющий показ нативной кнопки ApplePay вместо вебвьюшки              |
| applePayMerchantId  | String                               | нет          | Айдишка мерчанта, прописанная в консоли ApplePay                                |

Пример:

```
 let goods = [
           AirbaPaySdk.Goods(
               model: "Чай Tess Banana Split черный 20 пирамидок",
               brand: "Tess",
               category: "Черный чай",
               quantity: 1,
               price: 1000
           )
       ]

       let settlementPayment = [
           AirbaPaySdk.SettlementPayment(
               amount: 1000,
               companyId: "test_id"
           )
       ]
       
       AirbaPaySdk.initSdk(
            isProd: false,
            lang: AirbaPaySdk.Lang.RU(),
            accountId: ACCOUNT_ID_TEST,
            phone: PHONE,
            userEmail: "test@test.com",
            shopId: "test-baykanat",
            password: "baykanat123!",
            terminalId: "64216e7ccc4a48db060dd689",
            failureCallback: "https://site.kz/failure-clb",
            successCallback: "https://site.kz/success-clb",
            colorBrandMain: Color.red,
            autoCharge: autoCharge,
            purchaseAmount: 1500,
            invoiceId: String(someInvoiceId),
            orderNumber: String(someOrderNumber),
            goods: goods,
            settlementPayments: settlementPayment,
            isApplePayNative: true,
            shopName: "Shop Name",
            applePayMerchantId: "merchant.~"
   }


 ```

## 1.2 Вызов стартовой формы

```
@ObservedObject var navigateCoordinator = AirbaPayCoordinator(
            actionOnOpenProcessing: { ~ },
            actionOnCloseProcessing: { result in  ~ },
            customSuccessPageView: AnyView(~~~)
    )
```

Открытие формы AirbaPay выполняется через AirbaPaySdk.startAirbaPay().

| Параметр                   | Тип            | Обязательный | Описание                                                           |
|----------------------------|----------------|--------------|--------------------------------------------------------------------|
| isCustomSuccessPageView    | Bool           | нет          | Флаг переключения на кастомную вьюшку успешного кейса              |
| isCustomFinalErrorPageView | Bool           | нет          | Флаг переключения на кастомную вьюшку финального неуспешного кейса |
| actionOnOpenProcessing     | () -> Void     | нет          | Действие на открытие процессинга                                   |
| actionOnCloseProcessing    | (Bool) -> Void | нет          | Действие на закрытие процессинга с возвратом результата            | 

 ```
var body: some View {
           AirbaPayView(
                navigateCoordinator: navigateCoordinator,
                contentView: contentView
            )
}
 ```

| Параметр            | Тип                                 | Обязательный | Описание                                      |
|---------------------|-------------------------------------|--------------|-----------------------------------------------|
| navigateCoordinator | @ObservedObject AirbaPayCoordinator | да           | Координатор навигации                         |
| contentView         | AnyView?                            | да           | Контент страницы, на которой будет вызван sdk |

## 1.3 Пример использования

В случае наличия на странице системных элементов управления (к примеру, кнопки назад),
обязательно нужно скрыть их (в случае навигации в swiftUi через  ```.navigationBarBackButtonHidden(true) ```)

```
struct TestCustomSuccessPage: View {

    var body: some View {
        Button(action: {}, label: { Text("TestSuccessPage") })
    }
}



struct TestPage: View {
    var back: () -> Void
    var phone: String = ""

    @ObservedObject var navigateCoordinator = AirbaPayCoordinator(
            customSuccessPageView: AnyView(TestCustomSuccessPage())
    )

    var body: some View {
            AirbaPayView(
                    navigateCoordinator: navigateCoordinator,
                    contentView: {

                        VStack {
                                Button(
                                        action: {

                                            AirbaPaySdk.initSdk(~~~)
                                            navigateCoordinator.startProcessing()

                                        },

                                        label: {
                                            Text("переход на эквайринг")
                                        }
                                )
                                Spacer()
                            }
                    }
            )
    }
}
```

## 1.4 Подключение нативного ApplePay

1) Добавить параметры в initSdk
   ```isApplePayNative = true``` 
   ```applePayMerchantId = "merchant.~"```

2) Перейти в консоль ApplePay https://developer.apple.com/account/resources/identifiers/list 

3) Добавьте в Certificates
1й Type -> Apple Pay Payment Processing Certificate    Name ->  merchant.~.pf   
2й Type -> Apple Pay Merchant Identity Certificate     Name ->  merchant.~.pf   
3й Type -> Apple Pay Payment Processing Certificate    Name ->  merchant.~.spf   
4й Type -> Apple Pay Merchant Identity Certificate     Name ->  merchant.~.spf   

4) Перейти во внутрь идентификатора приложения. Поставьте галочку в ```Apple Pay Payment Processing``` и кликните edit

5) Выберите
   ~ Apple Pay Prod Service       merchant.~.pf
   ~ Apple Pay Test Service       merchant.~.spf
и нажмите continue

6) Нажмите Save

7) Зайдите в XCode в Targets -> Signing & Capabilities добавьте Apple Pay айди мерчантов поставьте галочки 



## 1.5 Подключение API внешнего взаимодействия с ApplePay (Нативный)

```buyBtnTapped```

| Параметр                        | Тип                                 | Обязательный | Описание                                       |
|---------------------------------|-------------------------------------|--------------|------------------------------------------------|
| redirectFromStoryboardToSwiftUi | (() -> Void)?                       | нет          | Замыкание перехода в сдк для storyboard        |
| backToStoryboard                | (() -> Void)?                       | нет          | Замыкание возврата в приложение для storyboard |


```ApplePayManager```

| Параметр              | Тип                                 | Обязательный | Описание                          |
|-----------------------|-------------------------------------|--------------|-----------------------------------|
| navigateCoordinator   | @ObservedObject AirbaPayCoordinator | да           | Координатор навигации             |



# SwiftUi:

1) Добавить, как указано в примере:

``` 
struct TestPage: View {
    
    @ObservedObject var navigateCoordinator = AirbaPayCoordinator(~)
    
     var body: some View {
        let applePay = ApplePayManager(navigateCoordinator: navigateCoordinator)

        AirbaPayView(
                navigateCoordinator: navigateCoordinator,
                contentView: {
                  // контент страницы приложения 
                  ~~~
                  
                  // кнопка продолжения 
                  Button(
                     action: {
                        ~~~
                        
                        AirbaPaySdk.initSdk(
                           ~
                           isApplePayNative: true,
                           shopName: ~,
                           applePayMerchantId:  "merchant.~"
                       )
                       
                       applePay.buyBtnTapped()
                       
                     }
                  )
                }
        )
     }           
```


# Storyboards:

## Внимание! Для storyboard недоступны кастомные страницы завершения


1. Добавить импорты во  ```ViewController```

```
import SwiftUI
import AirbaPay
```

2. Добавить

```
   @ObservedObject var navigateCoordinator = AirbaPayCoordinator()
```

3. Дальше надо выполнить ряд действий для подключения вьюшки в storyboard.
   Ниже описан кратко вариант интеграции. Более подробно описано в статье
   https://sarunw.com/posts/swiftui-view-as-uiview-in-storyboard/

- Добавить ```Container View``` и удалить привязанный к нему дефолтный ```ViewController```
- Добавить ```UIHostingController``` и привязать ```Container View``` к нему через ```"Embed```
- Связать это с ```ViewController``` кодом, указанным ниже

```
@IBSegueAction func addApplePay(_ coder: NSCoder) -> UIViewController? {
        
        AirbaPaySdk.initSdk(~)
        let applePay = ApplePayManager(navigateCoordinator: navigateCoordinator)

        return UIHostingController(coder: coder, rootView: SwiftUIView(
            actionOnClick: {
                let hostingController = UIHostingController(
                    rootView: AirbaPayNextStepApplePayView(navigateCoordinator: self.navigateCoordinator)
                )
                
                self.navigationController?.pushViewController(hostingController, animated: true)
            },
            actionOnClose: {
                self.navigationController?.popViewController(animated: true)
            },
            navigateCoordinator: navigateCoordinator,
            applePay: applePay
        ))
}

struct SwiftUIView: View {
    var actionOnClick: () -> Void
    var actionOnClose: () -> Void
    @ObservedObject var navigateCoordinator: AirbaPayCoordinator
    let applePay: ApplePayManager
 
    var body: some View {
        Button(
            action: {
               applePay.buyBtnTapped(
                        redirectFromStoryboardToSwiftUi: { actionOnClick() },
                        backToStoryboard: { actionOnClose() }
               )
            }
        )
    }
}
```


## 1.6 Подключение API внешнего взаимодействия с ApplePay (Вебвью)

Для работы с ApplePay потребуется вьюшка ```ApplePayView``` из ```AirbaPay```

| Параметр                        | Тип                                 | Обязательный | Описание                                       |
|---------------------------------|-------------------------------------|--------------|------------------------------------------------|
| redirectFromStoryboardToSwiftUi | (() -> Void)?                       | нет          | Замыкание перехода в сдк для storyboard        |
| backToStoryboard                | (() -> Void)?                       | нет          | Замыкание возврата в приложение для storyboard |
| navigateCoordinator             | @ObservedObject AirbaPayCoordinator | да           | Координатор навигации                          |
| isLoading                       | @escaping (Bool) -> Void            | да           | Замыкание для показа лоадинга или плейсхолдера |

# SwiftUi:

1. Выполнить в ```onAppear``` ```AirbaPaySdk.initSdk(~)```

2. Добавить ```@ObservedObject var navigateCoordinator = AirbaPayCoordinator(~)```

3. Обернуть страницу приложения в

```
AirbaPayView(
   navigateCoordinator: navigateCoordinator,
   contentView: {
      ~~~
      //Страница приложения 
      ~~~
      
      // Вьюшка ApplePay из AirbaPay
     
      ApplePayView(
                    navigateCoordinator: navigateCoordinator,
                    isLoading: { b in 
                        // Коллбэк для прогрессбара или плейсхолдера  
                    }
                )
                .frame(maxWidth: .infinity, alignment: .top)
                .frame(height: 48)
                .padding(.top, 8)
                .padding(.horizontal, 16)
      
   }
)
   
```

# Storyboards:

## Внимание! Для storyboard недоступны кастомные страницы завершения

1. Добавить импорты во  ```ViewController```

```
import SwiftUI
import AirbaPay
```

2. Добавить

```
   @ObservedObject var navigateCoordinator = AirbaPayCoordinator()
```

3. Дальше надо выполнить ряд действий для подключения вьюшки в storyboard.
   Ниже описан кратко вариант интеграции. Более подробно описано в статье
   https://sarunw.com/posts/swiftui-view-as-uiview-in-storyboard/

- Добавить ```Container View``` и удалить привязанный к нему дефолтный ```ViewController```
- Добавить ```UIHostingController``` и привязать ```Container View``` к нему через ```"Embed```
- Связать это с ```ViewController``` кодом, указанным ниже

```
@IBSegueAction func addApplePay(_ coder: NSCoder) -> UIViewController? {
        
        AirbaPaySdk.initSdk(~)

        return UIHostingController(coder: coder, rootView: SwiftUIView(
            actionOnClick: {
                let hostingController = UIHostingController(
                    rootView: AirbaPayNextStepApplePayView(navigateCoordinator: self.navigateCoordinator)
                )
                
                self.navigationController?.pushViewController(hostingController, animated: true)
            },
            actionOnClose: {
                self.navigationController?.popViewController(animated: true)
            },
            isLoading: { b in
               // Коллбэк для прогрессбара или плейсхолдера 
            }
        ))
}

struct SwiftUIView: View {
    var actionOnClick: () -> Void
    var actionOnClose: () -> Void
    var isLoading: (Bool) -> Void
    @ObservedObject var navigateCoordinator = AirbaPayCoordinator()
 
    var body: some View {
        ZStack {
            Color.gray
            Color.white
            VStack {                
                ApplePayView(
                    redirectFromStoryboardToSwiftUi: actionOnClick,
                    backToStoryboard: actionOnClose,
                    navigateCoordinator: navigateCoordinator,
                    isLoading: isLoading
                )
                .frame(maxWidth: .infinity, alignment: .top)
                .frame(height: 48)
                .padding(.top, 8)
                .padding(.horizontal, 16)
                
            }
        }
    }
}
```

## 1.7 Рекомендация в случае интеграции в flutter

1) В dart добавьте:

```
  final MethodChannel channel = MethodChannel("com.example.testFlutter/AirbaPayChannel");

  Future<void> callNativeMethod() async {
    try {
      await channel.invokeMethod('pay');
    } catch (e) {
      print('Error calling native method: $e');
    }
  }
```

И нужно вызвать ```callNativeMethod``` для перехода на страницы сдк.

2) Создайте файл ```AirbaPayHandler```

```

import Foundation
import Flutter
import AirbaPay
import SwiftUI

func handleAirbaPayChannel(
  _ app: AppDelegate,
  _ call: FlutterMethodCall,
  _ result: OneShotFlutterResult
) {
  let controller : FlutterViewController = app.window?.rootViewController as! FlutterViewController

  if call.method == "pay" {
    let lang: AirbaPaySdk.Lang = AirbaPaySdk.Lang.RU()

    let someInvoiceId = ~
    let someOrderNumber = ~
      
      let goods = AirbaPaySdk.Goods(
        brand: "TechnoFit",
        category: "Services",
        model: "asdafasfd",
        quantity: 1,
        price: 5500
      )
      
    AirbaPaySdk.initSdk(
      isProd: false,
      lang: lang,
      accountId: "10000001",
      phone: "+77050000010",
      userEmail: "asdasd@sad.com",
      shopId: "test-baykanat",
      password:  "baykanat123!",
      terminalId:  "64216e7ccc4a48db060dd689", 
      failureCallback: "https://site.kz/failure-clb",
      successCallback: "https://site.kz/success-clb",
      autoCharge: 0,
      enabledLogsForProd: true,
      purchaseAmount: 5500,
      invoiceId: String(someInvoiceId),
      orderNumber: String(someOrderNumber),
      goods: [goods]
    )

    controller.show(AirbaPayViewController(result: result), sender: controller)
  } else {
    result.submit(FlutterMethodNotImplemented)
  }
}



class OneShotFlutterResult {
  private var result: FlutterResult?
  
  init(_ result: @escaping FlutterResult) {
    self.result = result
  }
  
  func submit(_ data: Any) {
    if (result != nil) {
      result!(data)
      result = nil
    }
  }
}

```

3) Создайте файл ```AirbaPayViewController```

```

import Foundation
import SwiftUI
import AirbaPay

class AirbaPayViewController : UIHostingController<AirbaPayView> {
  private var result: OneShotFlutterResult? = nil
  
  init(
    result: OneShotFlutterResult
  ) {
    var lateSelf: AirbaPayViewController? = nil
    self.result = result
    let navigateCoordinator = AirbaPayCoordinator(
      actionOnCloseProcessing: { r in
        lateSelf?.dismiss(animated: false)
        result.submit(["result": r])
      }
    )
    
    let airbaPayView = AirbaPayView(navigateCoordinator: navigateCoordinator) {}
    
    navigateCoordinator.startProcessing()
    super.init(rootView: airbaPayView)
    lateSelf = self
    view.backgroundColor = UIColor.black.withAlphaComponent(0)
  }
  
  required dynamic init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    result?.submit(["result": false])
  }
  
  override func viewSafeAreaInsetsDidChange() {
    print("safe")
  }
}

```

4) Добавьте в ```AppDelegate```

```
let controller : FlutterViewController = window?.rootViewController as! FlutterViewController

let airbaPayChannel = FlutterMethodChannel(
     name: "com.example.testFlutter/AirbaPayChannel",
     binaryMessenger: controller.binaryMessenger
)
      
airbaPayChannel.setMethodCallHandler({ call, result -> Void in
     handleAirbaPayChannel(self, call, OneShotFlutterResult(result))
})
```