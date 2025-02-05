# RARS Installation and Usage Guide for Linux

Make sure you have Java 8 or higher installed on your system. To verify if Java is installed, run the following command:
```bash
java --version
```
If Java is not installed, you can install it with the following command:
```bash
sudo apt install openjdk-8-jdk
```
After installation, verify Java installation by running:
```bash
java --version
```

### Step 2: Install RARS

Download the **rars1_6.jar** file from the Linux folder of this repository. Once downloaded, you can run RARS by using the following command:
```bash
java -jar rars1_6.jar
```

### How to Execute RARS

To execute the `rars1_6.jar` file, follow these steps:
1. Open the terminal and navigate to the folder containing **rars1_6.jar** using the `cd` command.
2. Once you're in the correct directory, run the following command:
    ```bash
    java -jar rars1_6.jar
    ```
3. This will launch the RARS application in your terminal or GUI (depending on your setup).

### How to Use RARS

To write and execute RISC-V programs, follow these steps:
1. Write your RISC-V assembly program in the Edit window. Use the `.text` section for code and the `.globl main` directive to define the main function.
2. Save your program and click the wrench icon (or select **Run > Assemble**) to assemble your code.
3. To execute the program, click the green arrow. You can step through the instructions using other arrows in the toolbar.
4. The memory and registers are displayed during execution, so you can observe the changes in the program's state.

</div>

---

<div dir="rtl">

## راهنمای نصب و استفاده از RARS در لینوکس

RARS (مترجم و شبیه‌ساز زمان اجرا برای معماری RISC-V) ابزاری است که به شما امکان نوشتن و اجرای برنامه‌های اسمبلی RISC-V را می‌دهد. این ابزار به شما اجازه می‌دهد تا برنامه‌های خود را نوشته و گام به گام اجرا کنید تا نتایج آن‌ها را مشاهده کنید.

## دستورالعمل نصب

برای نصب Java و RARS در سیستم لینوکس خود، مراحل زیر را دنبال کنید:

### مرحله 1: نصب Java

اطمینان حاصل کنید که Java نسخه 8 یا بالاتر روی سیستم شما نصب است. برای بررسی نصب بودن Java، دستور زیر را وارد کنید:
```bash
java --version
```
اگر Java نصب نیست، می‌توانید با دستور زیر آن را نصب کنید:
```bash
sudo apt install openjdk-8-jdk
```
پس از نصب، دوباره با دستور زیر نصب بودن Java را بررسی کنید:
```bash
java --version
```

### مرحله 2: نصب RARS

فایل **rars1_6.jar** را از پوشه Linux در این مخزن دانلود کنید. پس از دانلود، برای اجرای RARS دستور زیر را وارد کنید:
```bash
java -jar rars1_6.jar
```

### نحوه اجرای RARS

برای اجرای فایل `rars1_6.jar`، مراحل زیر را دنبال کنید:
1. ترمینال را باز کرده و به پوشه‌ای که فایل **rars1_6.jar** در آن قرار دارد بروید، با استفاده از دستور `cd`.
2. پس از وارد شدن به پوشه صحیح، دستور زیر را وارد کنید:
    ```bash
    java -jar rars1_6.jar
    ```
3. این دستور RARS را در ترمینال یا محیط گرافیکی (بسته به تنظیمات سیستم شما) اجرا می‌کند.

### نحوه استفاده از RARS

برای نوشتن و اجرای برنامه‌های RISC-V مراحل زیر را دنبال کنید:
1. برنامه اسمبلی RISC-V خود را در پنجره ویرایش بنویسید. از بخش `.text` برای کد و دستور `.globl main` برای تعریف تابع اصلی استفاده کنید.
2. برنامه خود را ذخیره کرده و روی آیکون آچار کلیک کنید (یا از گزینه **Run > Assemble** استفاده کنید) تا کد خود را اسمبل کنید.
3. برای اجرای برنامه، روی پیکان سبز کلیک کنید. می‌توانید برای گام به گام اجرا کردن دستورات از دیگر پیکان‌ها استفاده کنید.
4. در طول اجرا، محتوای حافظه و رجیسترها نمایش داده می‌شود تا تغییرات در وضعیت برنامه را مشاهده کنید.

</div>
```

