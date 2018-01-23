" NORMAL:
nnoremap ,Controller   :-1read $HOME/vimfiles/snippets/php/Controller.php<CR>:%s/CLASS//<Left>
nnoremap ,Model        :-1read $HOME/vimfiles/snippets/php/Model.php<CR>:%s/CLASS//<Left>
nnoremap ,TTController :-1read $HOME/vimfiles/snippets/php/TTController.php<CR>:%s/CLASS//<Left>
nnoremap ,TTModel      :-1read $HOME/vimfiles/snippets/php/TTModel.php<CR>:%s/CLASS//<Left>
nnoremap ,TTTrait      :-1read $HOME/vimfiles/snippets/php/TTTrait.php<CR>:%s/CLASS//<Left>
nnoremap ,TestCase     :-1read $HOME/vimfiles/snippets/php/TestCase.php<CR>:%s/CLASS//<Left>

" INSERT:
inoremap @p<tab> @param 
inoremap @r<tab> @return 
inoremap $t<tab> $this->
inoremap fe<tab> foreach() {<CR>}<up><right><right><right><right><right><right><right>
inoremap pub<tab> public function 
inoremap pubs<tab> public static function 
inoremap pri<tab> private function 
inoremap pris<tab> private static function 
inoremap pro<tab> protected function 
inoremap pros<tab> protected static function 
inoremap TT<tab> TT::app()->
inoremap TTbu<tab> TT::app()->getBaseUrl(true)
inoremap TTbp<tab> TT::app()->basePath
inoremap TTp<tab> TT::app()->params
inoremap vd<tab>  var_dump();<Left><Left>
inoremap vde<tab> var_dump(); exit;<left><left><left><left><left><left><left><left>
