# سلسله‌مراتب حافظه و معماری کامپیوتر

<div dir="rtl">

## 📑 فهرست مطالب

- [مقدمه](#مقدمه)
- [اجزای اصلی کامپیوتر](#اجزای-اصلی-کامپیوتر)
- [مدارهای دیجیتال](#مدارهای-دیجیتال)
- [سلسله‌مراتب حافظه](#سلسله‌مراتب-حافظه)
- [اصول محلی‌گرایی](#اصول-محلی‌گرایی)
- [انواع حافظه](#انواع-حافظه)
- [حافظه کش](#حافظه-کش)
- [بهینه‌سازی عملکرد](#بهینه‌سازی-عملکرد)

---

## مقدمه

### 🎯 چرا سلسله‌مراتب حافظه؟

**مشکل اصلی:** شکاف سرعت بین پردازنده و حافظه

<div dir="ltr">

```
┌────────────────────────────────┐
│  CPU Speed   : 3 GHz           │
│  Memory Speed: 100 MHz         │
│                                │
│  Gap: 30x !! 😱                │
└────────────────────────────────┘
```

</div>

**راه‌حل:** استفاده از سلسله‌مراتب حافظه

<div dir="ltr">

```
        Fast & Small
             ▲
             │
    ┌────────┴────────┐
    │   Registers     │  ~1 cycle
    ├─────────────────┤
    │   L1 Cache      │  ~4 cycles
    ├─────────────────┤
    │   L2 Cache      │  ~10 cycles
    ├─────────────────┤
    │   L3 Cache      │  ~40 cycles
    ├─────────────────┤
    │   Main Memory   │  ~100 cycles
    ├─────────────────┤
    │   SSD           │  ~25,000 cycles
    ├─────────────────┤
    │   HDD           │  ~500,000 cycles
    └─────────────────┘
             │
             ▼
       Slow & Large
```

</div>

---

## اجزای اصلی کامپیوتر

### 🖥️ معماری فون نویمان

<div dir="ltr">

```
┌─────────────────────────────────────────┐
│              Computer                   │
│  ┌─────────────────────────────────┐   │
│  │           CPU                   │   │
│  │  ┌───────────┐  ┌────────────┐ │   │
│  │  │ Control   │  │  Datapath  │ │   │
│  │  │   Unit    │  │   (ALU)    │ │   │
│  │  └─────┬─────┘  └─────┬──────┘ │   │
│  └────────┼────────────── ┼────────┘   │
│           │               │            │
│  ┌────────┴───────────────┴────────┐   │
│  │          Memory                 │   │
│  │  ┌───────┐ ┌────────┐ ┌──────┐ │   │
│  │  │ Cache │ │  DRAM  │ │ Disk │ │   │
│  │  └───────┘ └────────┘ └──────┘ │   │
│  └─────────────────────────────────┘   │
│           │               │            │
│  ┌────────┴───────────────┴────────┐   │
│  │          I/O Devices            │   │
│  │  (Keyboard, Mouse, Display)     │   │
│  └─────────────────────────────────┘   │
└─────────────────────────────────────────┘
```

</div>

### 📊 جدول اجزا

<div dir="ltr">

| جزء | نقش | مثال |
|-----|-----|------|
| **CPU** | پردازش | Intel Core i7, AMD Ryzen |
| **Control Unit** | کنترل اجرا | Instruction Decoder |
| **Datapath** | محاسبات | ALU, Registers |
| **Memory** | ذخیره‌سازی | RAM, SSD, HDD |
| **I/O** | تعامل | Keyboard, Display |

</div>

---

## مدارهای دیجیتال

### ⚡ مدار ترکیبی (Combinational)

**تعریف:** خروجی فقط به ورودی فعلی بستگی دارد

**مثال‌ها:**

<div dir="ltr">

```
1. جمع‌کننده (Adder):
   Input: A, B
   Output: Sum = A + B

2. ضرب‌کننده (Multiplexer):
   Input: A, B, Select
   Output: Select ? B : A

3. رمزگشا (Decoder):
   Input: 2-bit
   Output: 4 lines (one-hot)
```

</div>

**نمودار:**

<div dir="ltr">

```
     A ──┐
         ├──► [ Adder ] ──► Sum
     B ──┘

خروجی = f(ورودی)
بدون حافظه!
```

</div>

### 🔄 مدار ترتیبی (Sequential)

**تعریف:** خروجی به ورودی فعلی **و** وضعیت قبلی بستگی دارد

**مثال‌ها:**

<div dir="ltr">

```
1. شمارنده (Counter):
   Output = Previous + 1

2. رجیستر (Register):
   Output = Last Input

3. ماشین حالت (State Machine):
   Next State = f(Current State, Input)
```

</div>

**نمودار:**

<div dir="ltr">

```
     Input ──┐
             ├──► [ Logic ] ──┬──► Output
     Clock ──┘                │
                              │
                    ┌─────────┴────┐
                    │   Register   │
                    │   (State)    │
                    └─────────┬────┘
                              │
              Feedback ◄──────┘

خروجی = f(ورودی, وضعیت)
با حافظه! ✅
```

</div>

### 📊 مقایسه

<div dir="ltr">

| ویژگی | ترکیبی | ترتیبی |
|-------|--------|--------|
| **حافظه** | ❌ ندارد | ✅ دارد |
| **Clock** | ❌ نیازی نیست | ✅ ضروری |
| **خروجی** | فوری | بعد از Clock |
| **مثال** | Adder, MUX | Register, Counter |
| **کاربرد** | محاسبات | ذخیره‌سازی |

</div>

---

## سلسله‌مراتب حافظه

### 📈 مشکل: شکاف سرعت

**رشد سرعت CPU vs Memory:**

<div dir="ltr">

```
Year:  1980   1990   2000   2010   2020
       │      │      │      │      │
CPU:   1x ──► 10x ──► 100x ──► 1000x ──► 10000x
       │      │      │      │      │
Memory:1x ──► 2x  ──► 5x  ──► 10x  ──► 20x

Gap = 500x !! 😱
```

</div>

### 🏗️ ساختار سلسله‌مراتب

<div dir="ltr">

```
┌─────────────────────────────────────────┐
│  Level 1: Registers                     │
│  Size: 1KB, Speed: 1 cycle, Cost: $$$$ │
├─────────────────────────────────────────┤
│  Level 2: L1 Cache                      │
│  Size: 32KB, Speed: 4 cycles, Cost: $$$ │
├─────────────────────────────────────────┤
│  Level 3: L2 Cache                      │
│  Size: 256KB, Speed: 10 cycles, Cost: $$│
├─────────────────────────────────────────┤
│  Level 4: L3 Cache                      │
│  Size: 8MB, Speed: 40 cycles, Cost: $  │
├─────────────────────────────────────────┤
│  Level 5: Main Memory (DRAM)           │
│  Size: 16GB, Speed: 100 cycles, Cost: ¢ │
├─────────────────────────────────────────┤
│  Level 6: SSD                           │
│  Size: 512GB, Speed: 25K cycles         │
├─────────────────────────────────────────┤
│  Level 7: HDD                           │
│  Size: 2TB, Speed: 500K cycles          │
└─────────────────────────────────────────┘
```

</div>

### 📊 جدول مقایسه

<div dir="ltr">

| سطح | اندازه | سرعت (ns) | قیمت ($/GB) | تکنولوژی |
|-----|---------|----------|-------------|-----------|
| **Registers** | ~1 KB | 0.3 | - | SRAM |
| **L1 Cache** | 32 KB | 1 | $10,000 | SRAM |
| **L2 Cache** | 256 KB | 3 | $5,000 | SRAM |
| **L3 Cache** | 8 MB | 12 | $1,000 | SRAM |
| **DRAM** | 16 GB | 50 | $5 | DRAM |
| **SSD** | 512 GB | 100,000 | $0.2 | NAND Flash |
| **HDD** | 2 TB | 5,000,000 | $0.05 | Magnetic |

</div>

### 💡 اصل کار

**Goal:** ایجاد توهم حافظه‌ای که:
- به سرعت Registers
- به اندازه Disk
- به قیمت HDD

**روش:** استفاده از محلی‌گرایی (Locality)

---

## اصول محلی‌گرایی

### ⏰ محلی‌گرایی زمانی (Temporal Locality)

**تعریف:** اگر به داده‌ای دسترسی پیدا کردیم، احتمالاً به زودی دوباره به آن نیاز داریم.

**مثال:**

<div dir="ltr">

```c
// متغیرهای حلقه
for (int i = 0; i < n; i++) {  // i: خوانده می‌شود بارها
    sum += array[i];            // sum: خوانده/نوشته می‌شود بارها
}
```

</div>

**نمودار دسترسی:**

<div dir="ltr">

```
Time:   t1    t2    t3    t4    t5    t6
Access: A  →  B  →  A  →  C  →  A  →  B
        │           ▲           ▲
        └───────────┴───────────┘
        بازگشت مکرر به A!
```

</div>

### 📍 محلی‌گرایی مکانی (Spatial Locality)

**تعریف:** اگر به آدرس X دسترسی داشتیم، احتمالاً به X+1, X+2, ... نیز نیاز داریم.

**مثال:**

<div dir="ltr">

```c
// پیمایش آرایه
int array[100];
for (int i = 0; i < 100; i++) {
    sum += array[i];  // دسترسی متوالی
}
```

</div>

**نمودار:**

<div dir="ltr">

```
Memory: [A0][A1][A2][A3][A4][A5][A6][A7]
         ▲   ▲   ▲   ▲
         └───┴───┴───┘
        دسترسی متوالی!
```

</div>

### 📊 مثال ترکیبی

<div dir="ltr">

```c
// ضرب ماتریس
for (int i = 0; i < N; i++) {           // i: Temporal
    for (int j = 0; j < N; j++) {       // j: Temporal
        for (int k = 0; k < N; k++) {   // k: Temporal
            C[i][j] += A[i][k] * B[k][j];
            // A[i][k]: Spatial (k++)
            // B[k][j]: متغیر
            // C[i][j]: Temporal
        }
    }
}
```

</div>

### 💡 استفاده در Cache

<div dir="ltr">

```
Temporal → نگه داشتن داده در Cache
Spatial  → بارگذاری Block (نه فقط یک byte)

مثال:
Access to address 0x1000:
  → Load entire block: 0x1000-0x103F (64 bytes)
```

</div>

---

## انواع حافظه

### 🎯 RAM - Random Access Memory

**ویژگی‌ها:**
- زمان دسترسی یکسان به هر آدرس
- volatile (با قطع برق، داده از دست می‌رود)

**انواع:**

### 1️⃣ SRAM - Static RAM

**ساختار:**

<div dir="ltr">

```
┌────────────────┐
│  6 Transistor  │
│   Per Cell     │
│                │
│  ┌──┐  ┌──┐   │
│  │  ├──┤  │   │
│  └──┘  └──┘   │
│   Fast & $$$  │
└────────────────┘
```

</div>

**مشخصات:**

<div dir="ltr">

| ویژگی | مقدار |
|-------|-------|
| **سرعت** | 1-10 ns |
| **چگالی** | کم |
| **قیمت** | بالا ($10,000/GB) |
| **مصرف** | بالا |
| **Refresh** | ❌ نیازی نیست |
| **کاربرد** | Cache (L1, L2, L3) |

</div>

### 2️⃣ DRAM - Dynamic RAM

**ساختار:**

<div dir="ltr">

```
┌────────────────┐
│ 1 Transistor + │
│  1 Capacitor   │
│                │
│     ┌─┐        │
│  ───┤ ├───     │
│     └─┘        │
│  Slow & Cheap  │
└────────────────┘
```

</div>

**مشخصات:**

<div dir="ltr">

| ویژگی | مقدار |
|-------|-------|
| **سرعت** | 50-100 ns |
| **چگالی** | بالا |
| **قیمت** | پایین ($5/GB) |
| **مصرف** | متوسط |
| **Refresh** | ✅ هر 64ms |
| **کاربرد** | Main Memory |

</div>

### 📊 مقایسه SRAM vs DRAM

<div dir="ltr">

| جنبه | SRAM | DRAM |
|------|------|------|
| **سرعت** | ⚡⚡⚡⚡⚡ | ⚡⚡ |
| **چگالی** | 📦 | 📦📦📦📦📦 |
| **قیمت** | 💰💰💰💰💰 | 💰 |
| **پیچیدگی** | پیچیده | ساده |
| **Refresh** | ❌ | ✅ هر 64ms |
| **استفاده** | Cache | RAM |

</div>

### 🔄 SDRAM - Synchronous DRAM

**ویژگی:**
- همگام با Clock سیستم
- pipeline کردن دسترسی‌ها

<div dir="ltr">

```
Clock:  ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐
        │ │ │ │ │ │ │ │ │ │
        └─┘ └─┘ └─┘ └─┘ └─┘
        
Cmd:    [A] [B] [C] [D] [E]
Data:       [A] [B] [C] [D]
```

</div>

### ⚡ DDR SDRAM - Double Data Rate

**ویژگی:**
- انتقال در **هر دو** لبه Clock
- دو برابر سرعت SDRAM

<div dir="ltr">

```
Clock:  ┌─┐   ┌─┐   ┌─┐
        │ │   │ │   │ │
        └─┘   └─┘   └─┘
        ↓ ↓   ↓ ↓   ↓ ↓
Data:   A B   C D   E F

2x throughput! 🚀
```

</div>

**نسخه‌ها:**

<div dir="ltr">

| نسخه | سال | سرعت (MHz) | پهنای باند (GB/s) |
|------|-----|-----------|-------------------|
| **SDR** | 1996 | 133 | 1.06 |
| **DDR** | 2000 | 266 | 2.13 |
| **DDR2** | 2003 | 533 | 4.26 |
| **DDR3** | 2007 | 1066 | 8.53 |
| **DDR4** | 2014 | 2133 | 17.06 |
| **DDR5** | 2020 | 4800 | 38.4 |

</div>

---

## حافظه کش

### 📦 مفاهیم پایه

**Block:** کوچک‌ترین واحد انتقال

<div dir="ltr">

```
Block Size: معمولاً 64 bytes

Memory:  [Block 0][Block 1][Block 2]...
          64B      64B      64B
```

</div>

**Hit vs Miss:**

<div dir="ltr">

```
CPU Request
     │
     ▼
┌──────────┐
│  Cache?  │
└────┬─────┘
     │
  ┌──┴──┐
 Hit   Miss
  │      │
  ▼      ▼
Return  Go to
Data    Memory
```

</div>

### 📊 معیارهای عملکرد

<div dir="ltr">

```
Hit Rate = Hits / Total Accesses
Miss Rate = Misses / Total Accesses = 1 - Hit Rate

AMAT (Average Memory Access Time):
= Hit Time + Miss Rate × Miss Penalty

مثال:
  Hit Time = 1 cycle
  Miss Rate = 5%
  Miss Penalty = 100 cycles
  
  AMAT = 1 + 0.05 × 100 = 6 cycles
```

</div>

### 🎯 انواع Miss

**1. Compulsory Miss (Cold Miss)**
- اولین بار که به داده دسترسی پیدا می‌کنیم

**2. Capacity Miss**
- Cache کوچک است، داده قبلی خارج شده

**3. Conflict Miss**
- تداخل در یک خط کش (فقط در Direct-Mapped)

<div dir="ltr">

```
مثال:
Access: A, B, C, A, D

A: Compulsory Miss (اولین بار)
B: Compulsory Miss
C: Compulsory Miss
A: Hit (در Cache است)
D: Capacity Miss (A خارج شد)
```

</div>

### 🗺️ نگاشت آدرس به Cache

#### 1️⃣ Direct Mapped

<div dir="ltr">

```
هر Block فقط یک مکان در Cache دارد

Address: | Tag | Index | Offset |
           18    10       6

Cache Line = Address % Number_of_Lines
```

</div>

#### 2️⃣ Fully Associative

<div dir="ltr">

```
هر Block می‌تواند در هر جای Cache باشد

Address: | Tag | Offset |
           28      6

نیاز به جستجوی کامل!
```

</div>

#### 3️⃣ Set Associative

<div dir="ltr">

```
ترکیبی از هر دو
4-way: هر Set دارای 4 مکان

Address: | Tag | Index | Offset |
           20    8        6

Set = Address % Number_of_Sets
سپس جستجو در 4 مکان آن Set
```

</div>

### 📊 مقایسه

<div dir="ltr">

| نوع | Hit Time | Miss Rate | پیچیدگی | استفاده |
|-----|----------|-----------|----------|---------|
| **Direct** | سریع | بالا | ساده | L1 |
| **Fully Assoc** | کند | پایین | پیچیده | TLB |
| **Set Assoc** | متوسط | متوسط | متوسط | L2, L3 |

</div>

---

## بهینه‌سازی عملکرد

### 🚀 تکنیک‌های بهینه‌سازی

#### 1️⃣ Blocking (Tiling)

<div dir="ltr">

```c
// ❌ بدون Blocking - Cache Miss زیاد
for (i = 0; i < N; i++)
    for (j = 0; j < N; j++)
        for (k = 0; k < N; k++)
            C[i][j] += A[i][k] * B[k][j];

// ✅ با Blocking - Cache Miss کم
#define BLOCK 32
for (ii = 0; ii < N; ii += BLOCK)
    for (jj = 0; jj < N; jj += BLOCK)
        for (kk = 0; kk < N; kk += BLOCK)
            for (i = ii; i < ii+BLOCK; i++)
                for (j = jj; j < jj+BLOCK; j++)
                    for (k = kk; k < kk+BLOCK; k++)
                        C[i][j] += A[i][k] * B[k][j];
```

</div>

#### 2️⃣ Prefetching

<div dir="ltr">

```c
// پیش‌خوانی داده‌های آینده
for (i = 0; i < N; i++) {
    __builtin_prefetch(&array[i + 8]);  // پیش‌خوانی
    sum += array[i];
}
```

</div>

#### 3️⃣ Loop Interchange

<div dir="ltr">

```c
// ❌ بد - Stride بزرگ
for (i = 0; i < N; i++)
    for (j = 0; j < N; j++)
        A[j][i] = B[j][i] + C[j][i];

// ✅ خوب - Stride کوچک
for (j = 0; j < N; j++)
    for (i = 0; i < N; i++)
        A[j][i] = B[j][i] + C[j][i];
```

</div>

---

## 📚 منابع و مراجع

### 📖 مستندات
- [Computer Organization and Design: RISC-V Edition]
- [Memory Systems: Cache, DRAM, Disk]

### 🛠️ ابزارها
- Valgrind (cachegrind)
- perf (Linux performance tools)

---

<div align="center">


[⬆ بازگشت به بالا](#سلسله‌مراتب-حافظه-و-معماری-کامپیوتر)

</div>

</div>