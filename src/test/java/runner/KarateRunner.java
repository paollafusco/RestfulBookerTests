package runner;

import com.intuit.karate.junit5.Karate;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;

public class KarateRunner {

    @BeforeAll
    public static void setup() {
        System.setProperty("karate.report.dir", "target/karate-reports");
    }

    @Test
    public void testAll() {
        Karate.run("classpath:features").tags("~@bug", "~@ignore").parallel(6);
    }
}
