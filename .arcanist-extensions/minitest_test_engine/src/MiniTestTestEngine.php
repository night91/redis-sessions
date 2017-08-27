<?php

final class MiniTestTestEngine extends ArcanistUnitTestEngine {

  public function run() {
    $results = array();
    $command = $this->getConfigurationManager()->getConfigFromAnySource('unit.engine.minitest.command');
    if (!$command) $command = 'bundle exec rake test';

    $future = new ExecFuture($command );
    do {
      list($stdout, $stderr) = $future->read();
      if (strpos($stderr,'rake aborted') !== false) {
        $result = new ArcanistUnitTestResult();
        $result->setName('(UnitTest) Rake Test');
        $result->setResult(ArcanistUnitTestResult::RESULT_FAIL);
        $result->setUserData("THERE WERE ERRORS WHILE EXECUTING TESTS. Please run 'bundle exec rake test'\n");
        $results[] = $result;
      }
     sleep(0.5);
    } while (!$future->isReady());
    
    return $results; 
  }

  public function shouldEchoTestResults() {
    return true;
  }

}
