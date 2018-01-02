" NORMAL:
nnoremap ,Controller   :-1read $HOME/vimfiles/snippets/php/Controller.php<CR>:%s/CLASS//<Left>
nnoremap ,Model        :-1read $HOME/vimfiles/snippets/php/Model.php<CR>:%s/CLASS//<Left>
nnoremap ,TTController :-1read $HOME/vimfiles/snippets/php/TTController.php<CR>:%s/CLASS//<Left>
nnoremap ,TTModel      :-1read $HOME/vimfiles/snippets/php/TTModel.php<CR>:%s/CLASS//<Left>
nnoremap ,TTTrait      :-1read $HOME/vimfiles/snippets/php/TTTrait.php<CR>:%s/CLASS//<Left>
nnoremap ,TestCase     :-1read $HOME/vimfiles/snippets/php/TestCase.php<CR>:%s/CLASS//<Left>

" INSERT:
inoremap pub<tab> /**<CR><CR>/<CR>public function 
inoremap pubs<tab> /**<CR><CR>/<CR>public static function 
inoremap pri<tab> /**<CR><CR>/<CR>private function 
inoremap pris<tab> /**<CR><CR>/<CR>private static function 
inoremap pro<tab> /**<CR><CR>/<CR>protected function 
inoremap pros<tab> /**<CR><CR>/<CR>protected static function 
inoremap vd<tab>  vardump();<Left><Left>
inoremap vde<tab> vardump(); exit;<left><left><left><left><left><left><left><left>
