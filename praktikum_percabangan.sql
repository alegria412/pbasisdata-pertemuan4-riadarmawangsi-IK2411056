-- Hapus tabel jika ada
DROP TABLE IF EXISTS produk;

-- Buat tabel produk
CREATE TABLE produk (
    id_produk INT AUTO_INCREMENT PRIMARY KEY,
    nama_produk VARCHAR(100),
    stok INT
);

-- Isi data
INSERT INTO produk (nama_produk, stok) VALUES
('Pensil', 3),
('Buku', 10),
('Penghapus', 0),
('Pulpen', 25),
('Spidol', 6);

-- =====================================
-- LATIHAN 1: PROCEDURE CEK STATUS STOK
-- =====================================
DROP PROCEDURE IF EXISTS cek_status_stok;
DELIMITER $$

CREATE PROCEDURE cek_status_stok(IN p_stok INT)
BEGIN
    DECLARE v_status VARCHAR(50);

    IF p_stok = 0 THEN
        SET v_status = 'Habis';
    ELSEIF p_stok BETWEEN 1 AND 5 THEN
        SET v_status = 'Hampir Habis';
    ELSEIF p_stok BETWEEN 6 AND 20 THEN
        SET v_status = 'Tersedia';
    ELSE
        SET v_status = 'Stok Aman';
    END IF;

    SELECT p_stok AS stok, v_status AS status;
END $$

DELIMITER ;

-- =====================================
-- LATIHAN 2: CASE DALAM SELECT
-- =====================================
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

-- =====================================
-- LATIHAN 3: PROCEDURE HITUNG DISKON
-- =====================================
DROP PROCEDURE IF EXISTS hitung_diskon;
DELIMITER $$

CREATE PROCEDURE hitung_diskon(IN p_total DECIMAL(12,2))
BEGIN
    DECLARE v_persen INT;
    DECLARE v_diskon DECIMAL(12,2);
    DECLARE v_total_bayar DECIMAL(12,2);

    IF p_total >= 1000000 THEN
        SET v_persen = 15;
    ELSEIF p_total >= 500000 THEN
        SET v_persen = 10;
    ELSEIF p_total >= 250000 THEN
        SET v_persen = 5;
    ELSE
        SET v_persen = 0;
    END IF;

    SET v_diskon = p_total * v_persen / 100;
    SET v_total_bayar = p_total - v_diskon;

    SELECT 
        p_total AS total_belanja,
        v_persen AS diskon_persen,
        v_diskon AS jumlah_diskon,
        v_total_bayar AS total_bayar;
END $$

DELIMITER ;

-- =====================================
-- KUIS: CEK PREDIKAT MAHASISWA
-- =====================================
DROP PROCEDURE IF EXISTS cek_predikat_mahasiswa;
DELIMITER $$

CREATE PROCEDURE cek_predikat_mahasiswa(IN p_nilai DECIMAL(5,2))
BEGIN
    DECLARE v_predikat VARCHAR(50);
    DECLARE v_status VARCHAR(50);

    IF p_nilai >= 90 THEN
        SET v_predikat = 'Sangat Memuaskan';
    ELSEIF p_nilai >= 80 THEN
        SET v_predikat = 'Memuaskan';
    ELSEIF p_nilai >= 70 THEN
        SET v_predikat = 'Baik';
    ELSEIF p_nilai >= 60 THEN
        SET v_predikat = 'Cukup';
    ELSE
        SET v_predikat = 'Kurang';
    END IF;

    IF p_nilai >= 70 THEN
        SET v_status = 'Lulus';
    ELSE
        SET v_status = 'Tidak Lulus';
    END IF;

    SELECT 
        p_nilai AS nilai,
        v_predikat AS predikat,
        v_status AS status_kelulusan;
END $$

DELIMITER ;

-- =====================================
-- CONTOH PEMANGGILAN (TEST)
-- =====================================
CALL cek_status_stok(3);
CALL hitung_diskon(750000);
CALL cek_predikat_mahasiswa(85);
