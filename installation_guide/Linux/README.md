# Creating an HTML file with the content for both English and Persian sections, formatted for right-to-left (RTL) and left-to-right (LTR) text directions.

html_content = """
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RARS Installation Guide</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
        }
        .container {
            display: flex;
            justify-content: space-between;
            gap: 20px;
        }
        .english, .persian {
            width: 45%;
        }
        .persian {
            direction: rtl;
            text-align: right;
        }
        .english {
            direction: ltr;
            text-align: left;
        }
        h2 {
            color: #2C3E50;
        }
        p, li {
            font-size: 16px;
        }
        .code {
            background-color: #f4f4f4;
            padding: 10px;
            border-radius: 5px;
            font-family: "Courier New", monospace;
        }
    </style>
</head>
<body>

    <div class="container">
        <div class="english">
            <h2>Installing and Using RARS</h2>
            <p><strong>RARS</strong> - RISC-V Assembler and Runtime Simulator is an assembler and simulator for the RISC-V architecture. It allows you to write RISC-V assembly programs, and execute and step through the programs that you have written in assembly.</p>

            <h3>Installation Instructions</h3>
            <ol>
                <li><strong>Make sure you have Java 8 installed.</strong> Run <code>java --version</code> to check. Java 8, Java 11, and Java 17 have been tested and are known to work with RARS.</li>
                <li><strong>If you don't have Java installed:</strong>
                    <ul>
                        <li>Use this link to learn how to install Java on Ubuntu: <a href="https://www.theserverside.com/blog/Coffee-Talk-Java-News-Stories-and-Opinions/How-do-I-install-Java-on-Ubuntu#:~:text=While%20Ubuntu%20does%20not%20come,Java%20with%20the%20apt%20command" target="_blank">Install Java on Ubuntu</a></li>
                        <li>Install Java via terminal: <code>sudo apt install default-jdk</code></li>
                        <li>Check the installation: <code>java -jar</code></li>
                    </ul>
                </li>
                <li><strong>Install RARS:</strong>
                    <ul>
                        <li>Clone this repository to get the .jar file.</li>
                        <li>OR download the latest version from <a href="https://github.com/TheThirdOne/rars/releases" target="_blank">RARS GitHub releases</a>.</li>
                    </ul>
                </li>
                <li><strong>Run the .jar file using Java:</strong> Use the following command in the terminal: <code>java -jar &lt;path_to_rars.jar&gt;</code></li>
            </ol>

            <h3>How to Use RARS</h3>
            <ul>
                <li>Write your RISC-V assembly program in the <strong>Edit window</strong>.</li>
                <li>Assemble the program by saving and clicking the <strong>wrench icon</strong>.</li>
                <li>Execute your program using the <strong>green arrow</strong>.</li>
                <li>View memory and register contents during/after execution.</li>
            </ul>
        </div>

        <div class="persian">
            <h2>نصب و استفاده از RARS</h2>
            <p><strong>RARS</strong> - اسمبلر و شبیه‌ساز زمان اجرایی معماری RISC-V است که به شما این امکان را می‌دهد که برنامه‌های اسمبلی RISC-V بنویسید و آن‌ها را اجرا و گام‌به‌گام بررسی کنید.</p>

            <h3>دستورالعمل‌های نصب</h3>
            <ol>
                <li><strong>مطمئن شوید که Java 8 نصب است.</strong> دستور <code>java --version</code> را برای بررسی اجرا کنید. نسخه‌های Java 8، 11 و 17 به‌طور کامل با RARS کار می‌کنند.</li>
                <li><strong>اگر Java ندارید:</strong>
                    <ul>
                        <li>از این لینک برای یادگیری نحوه نصب Java بر روی اوبونتو استفاده کنید: <a href="https://www.theserverside.com/blog/Coffee-Talk-Java-News-Stories-and-Opinions/How-do-I-install-Java-on-Ubuntu#:~:text=While%20Ubuntu%20does%20not%20come,Java%20with%20the%20apt%20command" target="_blank">نصب Java در اوبونتو</a></li>
                        <li>Java را با دستور زیر نصب کنید: <code>sudo apt install default-jdk</code></li>
                        <li>نصب را بررسی کنید: <code>java -jar</code></li>
                    </ul>
                </li>
                <li><strong>نصب RARS:</strong>
                    <ul>
                        <li>این مخزن را کلون کنید تا فایل .jar را دریافت کنید.</li>
                        <li>یا آخرین نسخه RARS را از <a href="https://github.com/TheThirdOne/rars/releases" target="_blank">RARS GitHub releases</a> دانلود کنید.</li>
                    </ul>
                </li>
                <li><strong>اجرای فایل .jar با استفاده از Java:</strong> از دستور زیر در ترمینال استفاده کنید: <code>java -jar &lt;path_to_rars.jar&gt;</code></li>
            </ol>

            <h3>نحوه استفاده از RARS</h3>
            <ul>
                <li>برنامه اسمبلی خود را در <strong>پنجره ویرایش</strong> بنویسید.</li>
                <li>برنامه را با ذخیره و کلیک روی <strong>آیکون آچار</strong> اسمبلی کنید.</li>
                <li>برنامه خود را با استفاده از <strong>فلش سبز</strong> اجرا کنید.</li>
                <li>محتوای حافظه و رجیسترها را در حین یا بعد از اجرای برنامه مشاهده کنید.</li>
            </ul>
        </div>
    </div>

</body>
</html>
"""

# Saving to an HTML file
file_path = "/mnt/data/rars_installation_guide.html"
with open(file_path, "w") as file:
    file.write(html_content)

file_path
