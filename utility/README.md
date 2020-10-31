# Utility

## Penggunaan

Install dependensi terlebih dahulu dengan menjalankan perintah di bawah ini:

```python
# untuk pip pada python 3
pip3 install -r requirements.txt

# untuk pip pada python 2
pip install -r requirements.txt
```

Untuk menggunakan pairwise.py, isi file pairwise.txt dengan nilai yang diperlukan:

_pairwise.txt_ :

```
{match},{mismatch},{gap}
{sequence ke 1}
{sequence ke 2}
```

Setelah terisi, jalankan dengan command

```python
# untuk python 3
python3 pairwise.py

# untuk python 2
python pairwise.py
```

Untuk menggunakan multiseq.py, isi file multiseq.txt dengan nilai yang diperlukan:

_multiseq.txt_ :

```
{match},{mismatch},{gap}
{pivot sequence ke 1}
{pivot sequence ke 2}
...
{pivot sequence ke n}
```

```python
# untuk python 3
python3 multiseq.py

# untuk python 2
python pairwise.py
```

Jika ingin menggunakan sequence yg awal dan mencari alignment dari beberapa sequence, gunakan `multialign.py` karena multiseq digunakan untuk mengenerate hasil dari `multialign.py`.

## Catatan Penting

Versi python yang digunakan pada saat pembuatan kode adalah versi 3.8.6, apabila versi berbeda bisa disesuakan dengan kebutuhan sendiri.
