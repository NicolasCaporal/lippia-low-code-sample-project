package ar.steps;

import io.lippia.api.lowcode.steps.StepsInCommon;
import io.cucumber.java.en.*;
import java.time.Instant;

import java.io.UnsupportedEncodingException;

public class UtilSteps {

    private StepsInCommon stepsInCommon  = new StepsInCommon();

    @Given("^define random ([^\\d]\\S+) = ([^\\s].*)$")
    public void timeStampName(String key, String value) throws UnsupportedEncodingException {
        long unixTimestamp = Instant.now().getEpochSecond();
        stepsInCommon.setVariable(key, value+unixTimestamp);
    }


}
