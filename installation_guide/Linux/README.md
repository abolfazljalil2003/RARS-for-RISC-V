<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RARS Installation and Usage Guide (Linux)</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        .english {
            direction: ltr;
        }
        .persian {
            direction: rtl;
            font-family: Tahoma, sans-serif;
        }
    </style>
</head>
<body>

    <div class="english">
        <h1>RARS Installation and Usage Guide for Linux</h1>
        <p>RARS (RISC-V Assembler and Runtime Simulator) is an assembler and simulator for the RISC-V architecture. You can write and execute RISC-V assembly programs with the ability to step through them and observe the results.</p>

        <h2>Installation Instructions</h2>
        <p>Follow these steps to install Java and RARS on your Linux system:</p>

        <h3>Step 1: Install Java</h3>
        <p>Make sure you have Java 8 or higher installed on your system. To verify if Java is installed, run the following command:</p>
        <code>java --version</code>
        <p>If Java is not installed, you can install it with the following command:</p>
        <code>sudo apt install openjdk-8-jdk</code>
        <p>After installation, verify Java installation by running:</p>
        <code>java --version</code>

        <h3>Step 2: Install RARS</h3>
        <p>Download the <b>rars1_6.jar</b> file from the Linux folder of this repository. Once downloaded, you can run RARS by using the following command:</p>
        <code>java -jar rars1_6.jar</code>

        <h3>How to Execute RARS</h3>
        <p>To execute the `rars1_6.jar` file, follow these steps:</p>
        <ul>
            <li>Open the terminal and navigate to the folder containing <b>rars1_6.jar</b> using the <code>cd</code> command.</li>
            <li>Once you're in the correct directory, run the following command:</li>
            <code>java -jar rars1_6.jar</code>
            <li>This will launch the RARS application in your terminal or GUI (depending on your setup).</li>
        </ul>

        <h3>How to Use RARS</h3>
        <p>To write and execute RISC-V programs, follow these steps:</p>
        <ul>
            <li>Write your RISC-V assembly program in the Edit window. Use the <code>.text</code> section for code and the <code>.globl main</code> directive to define the main function.</li>
            <li>Save your program and click the wrench icon (or select <b>Run > Assemble</b>) to assemble your code.</li>
            <li>To execute the program, click the green arrow. You can step through the instructions using other arrows in the toolbar.</li>
            <li>The memory and registers are displayed during execution, so you can observe the changes in the program's state.</li>
        </ul>
    </div>

    <div class="persian">
        <h1>راهنمای نصب و استفاده از RARS در لینوکس</h1>
        <p>RARS (مترجم و شبیه‌ساز زمان اجرا برای معماری RISC-V) ابزاری است که به شما امکان نوشتن و اجرای برنامه‌های اسمبلی RISC-V را می‌دهد. این ابزار به شما اجازه می‌دهد تا برنامه‌های خود را نوشته و گام به گام اجرا کنید تا نتایج آن‌ها را مشاهده کنید.</p>

        <h2>دستورالعمل نصب</h2>
        <p>برای نصب Java و RARS در سیستم لینوکس خود، مراحل زیر را دنبال کنید:</p>

        <h3>مرحله 1: نصب Java</h3>
        <p>اطمینان حاصل کنید که Java نسخه 8 یا بالاتر روی سیستم شما نصب است. برای بررسی نصب بودن Java، دستور زیر را وارد کنید:</p>
        <code>java --version</code>
        <p>اگر Java نصب نیست، می‌توانید با دستور زیر آن را نصب کنید:</p>
        <code>sudo apt install openjdk-8-jdk</code>
        <p>پس از نصب، دوباره با دستور زیر نصب بودن Java را بررسی کنید:</p>
        <code>java --version</code>

        <h3>مرحله 2: نصب RARS</h3>
        <p>فایل <b>rars1_6.jar</b> را از پوشه Linux در این مخزن دانلود کنید. پس از دانلود، برای اجرای RARS دستور زیر را وارد کنید:</p>
        <code>java -jar rars1_6.jar</code>

        <h3>نحوه اجرای RARS</h3>
        <p>برای اجرای فایل `rars1_6.jar`، مراحل زیر را دنبال کنید:</p>
        <ul>
            <li>ترمینال را باز کرده و به پوشه‌ای که فایل <b>rars1_6.jar</b> در آن قرار دارد بروید، با استفاده از دستور <code>cd</code>.</li>
            <li>پس از وارد شدن به پوشه صحیح، دستور زیر را وارد کنید:</li>
            <code>java -jar rars1_6.jar</code>
            <li>این دستور RARS را در ترمینال یا محیط گرافیکی (بسته به تنظیمات سیستم شما) اجرا می‌کند.</li>
        </ul>

        <h3>نحوه استفاده از RARS</h3>
        <p>برای نوشتن و اجرای برنامه‌های RISC-V مراحل زیر را دنبال کنید:</p>
        <ul>
            <li>برنامه اسمبلی RISC-V خود را در پنجره ویرایش بنویسید. از بخش <code>.text</code> برای کد و دستور <code>.globl main</code> برای تعریف تابع اصلی استفاده کنید.</li>
            <li>برنامه خود را ذخیره کرده و روی آیکون آچار کلیک کنید (یا از گزینه <b>Run > Assemble</b> استفاده کنید) تا کد خود را اسمبل کنید.</li>
            <li>برای اجرای برنامه، روی پیکان سبز کلیک کنید. می‌توانید برای گام به گام اجرا کردن دستورات از دیگر پیکان‌ها استفاده کنید.</li>
            <li>در طول اجرا، محتوای حافظه و رجیسترها نمایش داده می‌شود تا تغییرات در وضعیت برنامه را مشاهده کنید.</li>
        </ul>
    </div>

</body>
</html>
