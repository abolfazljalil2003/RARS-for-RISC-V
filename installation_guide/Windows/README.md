<div dir="ltr">
 <li><data value="1001">install rars on windows</data></li>


## Requirements
Before installing RARS on Windows, make sure you have the following requirements:
- **Java Runtime Environment (JRE) or Java Development Kit (JDK)** installed.
- **RARS JAR file**, which is included in this folder.

You can use the following files provided in this folder:
- `jre-8u441-windows-x64.exe` → Java Runtime Environment (JRE) version 8.
- `rars_3897cfa.jar` → RARS simulator.

Alternatively, you can download the latest versions from:
- [Oracle Java](https://www.oracle.com/java/technologies/javase-downloads.html) or [OpenJDK](https://openjdk.org/).
- [RARS GitHub Repository](https://github.com/TheThirdOne/rars).

## Installation Steps
1. **Install Java**
   - Run `jre-8u441-windows-x64.exe` from this folder and complete the installation.
   - If you prefer a different version, download and install it from the links above.
   - Verify installation by running the following command in Command Prompt:
     ```sh
     java -version
     ```
     If Java is installed correctly, you will see the version information.

2. **Run RARS**
   - Open a Command Prompt (CMD) or PowerShell.
   - Navigate to the folder where `rars_3897cfa.jar` is located.
   - Run RARS using the following command:
     ```sh
     java -jar rars_3897cfa.jar
     ```
   - The RARS GUI should now open.

## Notes
- If you get an error saying Java is not recognized, ensure that Java is properly installed and added to the system's `PATH` environment variable.
- If you prefer using RARS from the command line, you can pass additional arguments for assembling and running programs.
</div>

<div dir="rtl">
# نصب RARS در ویندوز

## پیش‌نیازها
قبل از نصب RARS بر روی ویندوز، مطمئن شوید که موارد زیر را دارید:
- **محیط اجرای جاوا (JRE) یا کیت توسعه جاوا (JDK)** نصب شده باشد.
- **فایل JAR مربوط به RARS** که در این پوشه موجود است.

شما می‌توانید از فایل‌های زیر که در این پوشه قرار داده شده‌اند استفاده کنید:
- `jre-8u441-windows-x64.exe` → نسخه ۸ محیط اجرای جاوا.
- `rars_3897cfa.jar` → شبیه‌ساز RARS.

همچنین، می‌توانید نسخه‌های جدیدتر را از لینک‌های زیر دریافت کنید:
- [Oracle Java](https://www.oracle.com/java/technologies/javase-downloads.html) یا [OpenJDK](https://openjdk.org/).
- [مخزن گیت‌هاب RARS](https://github.com/TheThirdOne/rars).

## مراحل نصب
1. **نصب جاوا**
   - فایل `jre-8u441-windows-x64.exe` را از این پوشه اجرا کنید و مراحل نصب را کامل کنید.
   - اگر نسخه دیگری را ترجیح می‌دهید، آن را از لینک‌های بالا دانلود و نصب کنید.
   - برای بررسی نصب، دستور زیر را در Command Prompt اجرا کنید:
     ```sh
     java -version
     ```
     اگر جاوا به درستی نصب شده باشد، اطلاعات نسخه نمایش داده می‌شود.

2. **اجرای RARS**
   - Command Prompt (CMD) یا PowerShell را باز کنید.
   - به پوشه‌ای که فایل `rars_3897cfa.jar` در آن قرار دارد، بروید.
   - دستور زیر را اجرا کنید:
     ```sh
     java -jar rars_3897cfa.jar
     ```
   - پنجره RARS باید باز شود.

## نکات
- اگر با خطای "Java is not recognized" مواجه شدید، مطمئن شوید که جاوا به درستی نصب شده و در متغیر محیطی `PATH` اضافه شده است.
- در صورتی که بخواهید RARS را از طریق خط فرمان اجرا کنید، می‌توانید آرگومان‌های اضافی برای اسمبلی و اجرای برنامه‌ها استفاده کنید.
</div>
