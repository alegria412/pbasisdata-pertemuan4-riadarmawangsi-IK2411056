DROP PROCEDURE IF EXISTS cek_status_stok;
DELIMITER $$

CREATE PROCEDURE cek_status_stok(IN p_stok INT)
BEGIN
    DECLARE status_stok VARCHAR(50);

    IF p_stok = 0 THEN
        SET status_stok = 'Habis';
    ELSEIF p_stok BETWEEN 1 AND 5 THEN
        SET status_stok = 'Hampir Habis';
    ELSEIF p_stok BETWEEN 6 AND 20 THEN
        SET status_stok = 'Tersedia';
    ELSE
        SET status_stok = 'Stok Aman';
    END IF;

    SELECT p_stok AS stok, status_stok;
END $$

DELIMITER ;

SELECT 
    id_produk,
    nama_produk,
    stok,
    CASE
        WHEN stok = 0 THEN 'Habis'
        WHEN stok BETWEEN 1 AND 5 THEN 'Hampir Habis'
        WHEN stok BETWEEN 6 AND 20 THEN 'Tersedia'
        ELSE 'Stok Aman'
    END AS status_stok
FROM produk;

DROP PROCEDURE IF EXISTS hitung_diskon;
DELIMITER $$

CREATE PROCEDURE hitung_diskon(IN total_belanja DECIMAL(12,2))
BEGIN
    DECLARE diskon INT;
    DECLARE jumlah_diskon DECIMAL(12,2);
    DECLARE total_bayar DECIMAL(12,2);

    IF total_belanja >= 1000000 THEN
        SET diskon = 15;
    ELSEIF total_belanja >= 500000 THEN
        SET diskon = 10;
    ELSEIF total_belanja >= 250000 THEN
        SET diskon = 5;
    ELSE
        SET diskon = 0;
    END IF;

    SET jumlah_diskon = total_belanja * diskon / 100;
    SET total_bayar = total_belanja - jumlah_diskon;

    SELECT total_belanja, diskon, jumlah_diskon, total_bayar;
END $$

DELIMITER ;

DROP PROCEDURE IF EXISTS cek_predikat_mahasiswa;
DELIMITER $$

CREATE PROCEDURE cek_predikat_mahasiswa(IN p_nilai INT)
BEGIN
    DECLARE predikat VARCHAR(50);
    DECLARE status VARCHAR(50);

    IF p_nilai >= 90 THEN
        SET predikat = 'Sangat Memuaskan';
    ELSEIF p_nilai >= 80 THEN
        SET predikat = 'Memuaskan';
    ELSEIF p_nilai >= 70 THEN
        SET predikat = 'Baik';
    ELSEIF p_nilai >= 60 THEN
        SET predikat = 'Cukup';
    ELSE
        SET predikat = 'Kurang';
    END IF;

    IF p_nilai >= 70 THEN
        SET status = 'Lulus';
    ELSE
        SET status = 'Tidak Lulus';
    END IF;

    SELECT p_nilai AS nilai, predikat, status;
END $$

DELIMITER ;