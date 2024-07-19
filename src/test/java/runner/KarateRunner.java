package runner;

import com.intuit.karate.junit5.Karate;

public class KarateRunner {

    @Karate.Test
    Karate testAll() {
        return (Karate) Karate.run("classpath:features").tags("~@ignore");
    }
}
