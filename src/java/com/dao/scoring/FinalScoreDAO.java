package com.dao.scoring;

import com.connection.DBConnect;
import com.scoring.bean.FinalScore;
import com.scoring.bean.JuryScore;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class FinalScoreDAO {

    DBConnect db = new DBConnect();

    public FinalScore getFinalScoreBySession(int sessionID) {
        String sql = "SELECT * FROM FINAL_SCORE WHERE sessionID = ?";

        try (Connection con = db.getConnection(); PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setInt(1, sessionID);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                return extractFinalScoreFromResultSet(rs);
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return null;
    }

    public int saveFinalScore(FinalScore finalScore) {
        String sql = "INSERT INTO FINAL_SCORE (sessionID, scoreDifficultyBody, scoreDifficultyApparatus, " +
                "scoreDTotal, scoreArtistic, scoreExecution, technicalDeduction, lineDeduction, " +
                "timeDeduction, finalScore) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?) " +
                "ON DUPLICATE KEY UPDATE scoreDifficultyBody = ?, scoreDifficultyApparatus = ?, " +
                "scoreDTotal = ?, scoreArtistic = ?, scoreExecution = ?, technicalDeduction = ?, " +
                "lineDeduction = ?, timeDeduction = ?, finalScore = ?, calculatedAt = ?";

        try (Connection con = db.getConnection();
                PreparedStatement pst = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            Timestamp now = new Timestamp(System.currentTimeMillis());

            pst.setInt(1, finalScore.getSessionID());
            pst.setDouble(2, finalScore.getScoreDifficultyBody());
            pst.setDouble(3, finalScore.getScoreDifficultyApparatus());
            pst.setDouble(4, finalScore.getScoreDTotal());
            pst.setDouble(5, finalScore.getScoreArtistic());
            pst.setDouble(6, finalScore.getScoreExecution());
            pst.setDouble(7, finalScore.getTechnicalDeduction());
            pst.setDouble(8, finalScore.getLineDeduction());
            pst.setDouble(9, finalScore.getTimeDeduction());
            pst.setDouble(10, finalScore.getFinalScore());

            pst.setDouble(11, finalScore.getScoreDifficultyBody());
            pst.setDouble(12, finalScore.getScoreDifficultyApparatus());
            pst.setDouble(13, finalScore.getScoreDTotal());
            pst.setDouble(14, finalScore.getScoreArtistic());
            pst.setDouble(15, finalScore.getScoreExecution());
            pst.setDouble(16, finalScore.getTechnicalDeduction());
            pst.setDouble(17, finalScore.getLineDeduction());
            pst.setDouble(18, finalScore.getTimeDeduction());
            pst.setDouble(19, finalScore.getFinalScore());
            pst.setTimestamp(20, now);

            pst.executeUpdate();

            ResultSet rs = pst.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return -1;
    }

    public FinalScore calculateAndSaveFinalScore(int sessionID) {
        JuryScoreDAO juryScoreDAO = new JuryScoreDAO();
        List<JuryScore> allScores = juryScoreDAO.getScoresBySession(sessionID);

        Map<String, List<Double>> scoresByCategory = new HashMap<>();
        for (JuryScore score : allScores) {
            if (score.getScoreValue() != null) {
                String category = score.getCategory();
                scoresByCategory.computeIfAbsent(category, k -> new ArrayList<>()).add(score.getScoreValue());
            }
        }

        FinalScore finalScore = new FinalScore(sessionID);

        double dbAvg = calculateAverage(scoresByCategory.getOrDefault("DB", new ArrayList<>()));
        finalScore.setScoreDifficultyBody(dbAvg);

        double daAvg = calculateAverage(scoresByCategory.getOrDefault("DA", new ArrayList<>()));
        finalScore.setScoreDifficultyApparatus(daAvg);

        double dTotal = dbAvg + daAvg;
        finalScore.setScoreDTotal(dTotal);

        double aMedian = calculateMedian(scoresByCategory.getOrDefault("A", new ArrayList<>()));
        finalScore.setScoreArtistic(aMedian);

        List<Double> eScores = new ArrayList<>();
        eScores.addAll(scoresByCategory.getOrDefault("E", new ArrayList<>()));
        eScores.addAll(scoresByCategory.getOrDefault("EXE", new ArrayList<>()));
        double eMedian = calculateTrimmedMedian(eScores);
        finalScore.setScoreExecution(eMedian);

        double lineDed = calculateDeduction(scoresByCategory.getOrDefault("LINE", new ArrayList<>()));
        finalScore.setLineDeduction(lineDed);

        double timeDed = calculateDeduction(scoresByCategory.getOrDefault("TIME", new ArrayList<>()));
        finalScore.setTimeDeduction(timeDed);

        double techDed = calculateDeduction(scoresByCategory.getOrDefault("RJ", new ArrayList<>()));
        finalScore.setTechnicalDeduction(techDed);

        // Logic matched with Score.java
        // Base Score = D_Total + (10 - E_Median) + (10 - A_Median)
        double baseScore = dTotal + (10 - eMedian) + (10 - aMedian);

        // Round to 2 decimal places (mimicking Score.java String.format("%.2f"))
        // Using Locale.US to ensure dot separator for parsing
        String baseScoreStr = String.format(java.util.Locale.US, "%.2f", baseScore);
        double baseScoreRounded = Double.parseDouble(baseScoreStr);

        // Final Score = Base_Rounded - Deductions
        double total = baseScoreRounded - lineDed - timeDed - techDed;
        finalScore.setFinalScore(Math.max(0, total));

        saveFinalScore(finalScore);
        return finalScore;
    }

    private double calculateAverage(List<Double> scores) {
        if (scores == null || scores.isEmpty()) {
            return 0.0;
        }
        double sum = 0;
        int count = 0;
        for (Double score : scores) {
            if (score > 0.0001) { // Ignore 0.0 to match Score.java logic
                sum += score;
                count++;
            }
        }
        if (count == 0)
            return 0.0;
        return sum / count;
    }

    private double calculateMedian(List<Double> scores) {
        if (scores == null || scores.isEmpty()) {
            return 0.0;
        }

        // Match Score.java logic: if only one non-zero score exists, use it
        List<Double> nonZero = new ArrayList<>();
        for (Double s : scores) {
            if (s > 0.0001)
                nonZero.add(s);
        }
        if (nonZero.size() == 1) {
            return nonZero.get(0);
        }

        List<Double> sorted = new ArrayList<>(scores);
        Collections.sort(sorted);
        int mid = sorted.size() / 2;
        if (sorted.size() % 2 == 0) {
            return (sorted.get(mid - 1) + sorted.get(mid)) / 2.0;
        }
        return sorted.get(mid);
    }

    private double calculateTrimmedMedian(List<Double> scores) {
        // Filter out 0.0 values first to ensure auto-filled missing scores don't affect calculation
        List<Double> nonZero = new ArrayList<>();
        if (scores != null) {
            for (Double s : scores) {
                if (s > 0.0001) nonZero.add(s);
            }
        }

        if (nonZero.isEmpty()) {
            return 0.0;
        }

        if (nonZero.size() < 4) {
            return calculateMedian(nonZero);
        }

        List<Double> sorted = new ArrayList<>(nonZero);
        Collections.sort(sorted);
        // Trim the highest and lowest
        List<Double> trimmed = sorted.subList(1, sorted.size() - 1);
        return calculateMedian(trimmed);
    }

    private double calculateDeduction(List<Double> scores) {
        if (scores == null || scores.isEmpty()) {
            return 0.0;
        }
        double sum = 0;
        for (Double score : scores) {
            sum += score;
        }
        return sum;
    }

    private FinalScore extractFinalScoreFromResultSet(ResultSet rs) throws SQLException {
        FinalScore score = new FinalScore();
        score.setFinalScoreID(rs.getInt("finalScoreID"));
        score.setSessionID(rs.getInt("sessionID"));
        score.setScoreDifficultyBody(rs.getDouble("scoreDifficultyBody"));
        score.setScoreDifficultyApparatus(rs.getDouble("scoreDifficultyApparatus"));
        score.setScoreDTotal(rs.getDouble("scoreDTotal"));
        score.setScoreArtistic(rs.getDouble("scoreArtistic"));
        score.setScoreExecution(rs.getDouble("scoreExecution"));
        score.setTechnicalDeduction(rs.getDouble("technicalDeduction"));
        score.setLineDeduction(rs.getDouble("lineDeduction"));
        score.setTimeDeduction(rs.getDouble("timeDeduction"));
        score.setFinalScore(rs.getDouble("finalScore"));
        score.setCalculatedAt(rs.getTimestamp("calculatedAt"));
        return score;
    }

    private void printSQLException(SQLException ex) {
        for (Throwable e : ex) {
            if (e instanceof SQLException) {
                e.printStackTrace(System.err);
                System.err.println("SQLState: " + ((SQLException) e).getSQLState());
                System.err.println("Error Code: " + ((SQLException) e).getErrorCode());
                System.err.println("Message: " + e.getMessage());
            }
        }
    }
}
