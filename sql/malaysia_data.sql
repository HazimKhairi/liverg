-- Malaysia Realisic Data Insert Script
-- Coach (Required for Teams)
INSERT INTO `coach` (`coachIC`, `coachName`, `coachPOD`, `fisioIC`, `fisioName`, `fisioPOD`) VALUES
('800101-10-5555', 'Nor Azura Binti Ramli', 'Klang, Selangor', '850505-10-5555', 'Dr. Aminah', 'Klang'),
('820202-14-6666', 'Elena Zholobova', 'Bukit Jalil, KL', '860606-14-6666', 'Dr. Wong', 'Cheras'),
('790303-08-7777', 'Chew Sze Yan', 'Ipoh, Perak', '870707-08-7777', 'Dr. Ravi', 'Ipoh'),
('850404-10-8888', 'Liew Hui Yuan', 'PJ, Selangor', '880808-10-8888', 'Dr. Tan', 'PJ'),
('880505-08-9999', 'Siti Sarah', 'Kampar, Perak', '890909-08-9999', 'Dr. Lim', 'Kampar'),
('810606-07-1111', 'Ooi Wei Ling', 'Georgetown, Penang', '901010-07-1111', 'Dr. Lee', 'Georgetown'),
('830707-13-2222', 'Shigeki Matsunaga', 'Kuching, Sarawak', '911111-13-2222', 'Dr. James', 'Kuching');

-- Teams (States/Districts)
INSERT INTO `team` (`teamID`, `teamName`, `coachIC`, `orgUsername`, `orgPassword`, `orgStatus`, `createdBy`) VALUES
(100, 'MSSM Selangor', '800101-10-5555', 'selangor_rg', 'selangor123', 'active', 2),
(101, 'MSSM Kuala Lumpur', '820202-14-6666', 'kl_rg', 'kl123', 'active', 2),
(102, 'SUKMA Perak', '790303-08-7777', 'perak_sukma', 'perak123', 'active', 2),
(103, 'MSSD Petaling Utama', '850404-10-8888', 'petaling_utama', 'petaling123', 'active', 2),
(104, 'MSSD Kinta Utara', '880505-08-9999', 'kinta_utara', 'kinta123', 'active', 2),
(105, 'MSSM Penang', '810606-07-1111', 'penang_rg', 'penang123', 'active', 2),
(106, 'SUKMA Sarawak', '830707-13-2222', 'sarawak_sukma', 'sarawak123', 'active', 2);


-- Events
INSERT INTO `event` (`eventID`, `eventName`, `eventDate`, `clerkID`, `teamID`, `createdBy`, `hasJuryScreen`, `juryAccessCode`) VALUES
(100, 'MSSM Rhythmic Gymnastics 2026', '2026-03-15', 136, 100, 2, 0, NULL),
(101, 'SUKMA XXI 2026', '2026-06-20', 136, 102, 2, 0, NULL),
(102, 'MSSD Petaling Utama Championship 2026', '2026-02-28', 136, 103, 2, 0, NULL),
(103, 'National Circuit Series 1 2026', '2026-04-10', 136, 101, 2, 0, NULL),
(104, 'Malaysia Open 2026', '2026-08-15', 136, 102, 2, 0, NULL);

-- Gymnasts (Sample of ~30)
INSERT INTO `gymnast` (`gymnastID`, `gymnastIC`, `gymnastName`, `gymnastSchool`, `gymnastCategory`, `clerkID`, `teamID`) VALUES
-- Selangor (Team 100)
(100, '120101-10-0001', 'Nurul Izzah Binti Azman', 'SK Seksyen 7', 'U12', 136, 100),
(101, '120202-10-0002', 'Tan Yi Ling', 'SJK(C) Lick Hung', 'U12', 136, 100),
(102, '140303-10-0003', 'Chloe Yap', 'Sri KDU', 'U9', 136, 100),
(103, '100404-10-0004', 'Aishah Humaira', 'SMK Damansara Utama', 'Junior', 136, 100),
(104, '080505-10-0005', 'Kavitha A/P Muthusamy', 'SMK Subang Jaya', 'Senior', 136, 100),
(105, '120606-10-0006', 'Lee Hui Xin', 'SJK(C) Puay Chai', 'U12', 136, 100),

-- KL (Team 101)
(106, '110707-14-0007', 'Puteri Sarah Liyana', 'SK Bukit Damansara', 'Junior', 136, 101),
(107, '090808-14-0008', 'Wong Pei Xian', 'Kuen Cheng High School', 'Senior', 136, 101),
(108, '130909-14-0009', 'Divya Nambiar', 'Fairview International', 'U12', 136, 101),
(109, '151010-14-0010', 'Lim Jia Yi', 'SJK(C) Kuen Cheng 2', 'U9', 136, 101),
(110, '071111-14-0011', 'Siti Aminah', 'Victoria Institution', 'Senior', 136, 101),

-- Perak (Team 102)
(111, '061212-08-0012', 'Ng Joe Ee', 'SMK St. Bernadette', 'Senior', 136, 102),
(112, '100101-08-0013', 'Nur Qistina', 'SMK Convent Tarcisian', 'Junior', 136, 102),
(113, '130202-08-0014', 'Lai Yun Jo', 'SJK(C) Ave Maria', 'U12', 136, 102),
(114, '080303-08-0015', 'Sharmini d/o Ravi', 'SMK Methodist (ACS)', 'Senior', 136, 102),

-- Petaling Utama (Team 103)
(115, '140404-10-0016', 'Zara Amani', 'SK Assunta 1', 'U9', 136, 103),
(116, '120505-10-0017', 'Chan Xue Qi', 'SJK(C) Yuk Chai', 'U12', 136, 103),
(117, '110606-10-0018', 'Preesha Nair', 'SK La Salle PJ', 'U12', 136, 103),
(118, '130707-10-0019', 'Tengku Maya', 'Sri Aman', 'U9', 136, 103),

-- Kinta Utara (Team 104)
(119, '090808-08-0020', 'Low Fang Yi', 'SMK Sam Tet', 'Junior', 136, 104),
(120, '100909-08-0021', 'Nurul Ain', 'SMK Raja Perempuan', 'Junior', 136, 104),
(121, '141010-08-0022', 'Chow Mei Ling', 'SJK(C) Min Tet', 'U9', 136, 104),

-- Penang (Team 105)
(122, '070101-07-0023', 'Teoh Ee Xin', 'Penang Chinese Girls', 'Senior', 136, 105),
(123, '110202-07-0024', 'Nur Alisya', 'SK Mutiara', 'U12', 136, 105),
(124, '080303-07-0025', 'Priya a/p Ananthan', 'Convent Light Street', 'Senior', 136, 105),

-- Sarawak (Team 106)
(125, '090404-13-0026', 'Dayang Nurfaizah', 'SMK St. Teresa', 'Junior', 136, 106),
(126, '100505-13-0027', 'Eunice Liu', 'Lodge School', 'Junior', 136, 106),
(127, '130606-13-0028', 'Brenda Yap', 'SJK(C) Chung Hua', 'U12', 136, 106);

-- Gymnast Registration (Registrations for Apparatus)
-- Logic: U9 (Free Hand, Ball), U12 (Free Hand, Hoop, Ball, Clubs), Junior/Senior (Hoop, Ball, Clubs, Ribbon)
-- Apparatus IDs: 1: Ball, 2: Clubs, 3: Hoop, 4: Ribbon, 5: Free Hand

-- Registering for Event 100 (MSSM)
INSERT INTO `gymnast_app` (`gymnastID`, `apparatusID`, `eventID`) VALUES
-- Selangor U12
(100, 5, 100), (100, 3, 100), (100, 1, 100),
(101, 5, 100), (101, 3, 100), (101, 1, 100),
(105, 5, 100), (105, 3, 100),
-- Selangor U9
(102, 5, 100), (102, 1, 100),
-- Selangor Junior/Senior
(103, 3, 100), (103, 1, 100), (103, 2, 100), (103, 4, 100),
(104, 3, 100), (104, 1, 100), (104, 2, 100), (104, 4, 100),
-- KL
(106, 3, 100), (106, 1, 100),
(108, 5, 100), (108, 3, 100),
-- Penang
(122, 3, 100), (122, 1, 100), (122, 2, 100),
(123, 5, 100), (123, 3, 100);

-- Registering for Event 101 (SUKMA) - Mostly Juniors/Seniors
INSERT INTO `gymnast_app` (`gymnastID`, `apparatusID`, `eventID`) VALUES
-- Perak
(111, 3, 101), (111, 1, 101), (111, 2, 101), (111, 4, 101),
(114, 3, 101), (114, 1, 101), (114, 2, 101), (114, 4, 101),
-- KL
(107, 3, 101), (107, 1, 101), (107, 2, 101),
(110, 3, 101), (110, 1, 101), (110, 2, 101),
-- Sarawak
(125, 3, 101), (125, 1, 101),
(126, 3, 101), (126, 1, 101),
-- Selangor
(104, 3, 101), (104, 1, 101);

-- Registering for Event 102 (MSSD Petaling Utama) - Mostly U9/U12
INSERT INTO `gymnast_app` (`gymnastID`, `apparatusID`, `eventID`) VALUES
(115, 5, 102), (115, 1, 102),
(116, 5, 102), (116, 3, 102),
(117, 5, 102), (117, 3, 102),
(118, 5, 102),
(100, 5, 102), -- Guest from Selangor Team
(102, 5, 102);

-- Registering for Event 103 (National Circuit)
INSERT INTO `gymnast_app` (`gymnastID`, `apparatusID`, `eventID`) VALUES
(111, 3, 103), (111, 1, 103),
(122, 3, 103), (122, 1, 103),
(107, 3, 103), (107, 1, 103),
(103, 3, 103), (103, 1, 103),
(125, 3, 103);

-- Registering for Event 104 (Malaysia Open)
INSERT INTO `gymnast_app` (`gymnastID`, `apparatusID`, `eventID`) VALUES
(111, 3, 104), (111, 4, 104),
(104, 3, 104), (104, 4, 104),
(124, 3, 104), (124, 4, 104),
(122, 4, 104),
(110, 4, 104);

-- Start List (Optional: Defines order)
-- Only adding for MSSM (Event 100) for demo purposes
INSERT INTO `start_list` (`eventID`, `gymnastID`, `apparatusID`, `startOrder`) VALUES
(100, 100, 5, 1),
(100, 102, 5, 2),
(100, 101, 5, 3),
(100, 105, 5, 4),
(100, 108, 5, 5),
(100, 123, 5, 6),
(100, 103, 3, 7),
(100, 104, 3, 8),
(100, 106, 3, 9),
(100, 122, 3, 10);
