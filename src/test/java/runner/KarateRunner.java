package runner;

import com.intuit.karate.junit5.Karate;

public class KarateRunner {

    @Karate.Test
    Karate testAll() {
        return (Karate) Karate.run("src/test/resources/features/GetRequests.feature").tags("~@ignore");
    }
}
