<?php

trait TTCLASSTrait {

}

if (!TT::classExists('CLASSTrait', false)) {

    trait CLASSTrait {
        use TTCLASSTrait;
    }

}

