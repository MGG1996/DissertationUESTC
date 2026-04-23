%%
%% This is file `DissertUESTC.bst',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% merlin.mbs  (with options: `seq-no,nm-rv,ed-rev,jnrlst,nmlm,x3,m3,dt-jnl,yr-com,dtrev,yrp-col,jttl-rm,thtit-a,volp-sp,pp-last,num-xser,btit-rm,bt-rm,bkpg-x,add-pub,pre-pub,url-doi,edparc,bkedcap,ppx,ed,abr,ednx,ord,xand,eprint,url,url-blk,em-x,nfss,')
%% ----------------------------------------
%% *** Dissertation style for UESTC since 2024 ***
%% 
%% Copyright 1994-2011 Patrick W Daly
 % ===============================================================
 % IMPORTANT NOTICE:
 % This bibliographic style (bst) file has been generated from one or
 % more master bibliographic style (mbs) files, listed above.
 %
 % This generated file can be redistributed and/or modified under the terms
 % of the LaTeX Project Public License Distributed from CTAN
 % archives in directory macros/latex/base/lppl.txt; either
 % version 1 of the License, or any later version.
 % ===============================================================
 % Name and version information of the main mbs file:
 % \ProvidesFile{merlin.mbs}[2011/11/18 4.33 (PWD, AO, DPC)]
 %   For use with BibTeX version 0.99a or later
 %-------------------------------------------------------------------
 % This bibliography style file is intended for texts in ENGLISH
 % This is a numerical citation style, and as such is standard LaTeX.
 % It requires no extra package to interface to the main text.
 % The form of the \bibitem entries is
 %   \bibitem{key}...
 % Usage of \cite is as follows:
 %   \cite{key} ==>>          [#]
 %   \cite[chap. 2]{key} ==>> [#, chap. 2]
 % where # is a number determined by the ordering in the reference list.
 % The order in the reference list is that by which the works were originally
 %   cited in the text, or that in the database.
 %---------------------------------------------------------------------

ENTRY
  { address
    archive
    author
    booktitle
    chapter
    citedate
    day
    doi
    edition
    editor
    eid
    eprint
    howpublished
    journal
    key
    language
    modifydate
    month
    note
    number
    organization
    pages
    publisher
    school
    series
    title
    translator
    type
    url
    volume
    year
    nation
  }
  {}
  { label }
INTEGERS { output.state before.all mid.sentence after.sentence after.block }
FUNCTION {init.state.consts}
{ #0 'before.all :=
  #1 'mid.sentence :=
  #2 'after.sentence :=
  #3 'after.block :=
}
STRINGS { s t}

%%% 根据当前“输出状态”确定在第二栈顶字面值尾部是否应该添加分隔符以及添加哪种分隔符：
%%% mid.sentence   状态添加 ", "
%%% after.block    状态添加 ".\n"
%%% before.all     状态不加
%%% after.sentence 状态添加 ". "
%%% 然后向输出缓冲区写入第二栈顶字面值，更改“输出状态”为mid.sentence，最后在栈中保留栈顶字面值
FUNCTION {output.nonnull}
{ 's :=
  output.state mid.sentence =
    { ", " * write$ }
    { output.state after.block =
        { add.period$ write$
          newline$
          "\newblock " write$
        }
        { output.state before.all =
            'write$
            { add.period$ " " * write$ }
          if$
        }
      if$
      mid.sentence 'output.state :=
    }
  if$
  s
}

%%% 判断栈顶字面值是否为空，若是，则推出栈顶的空字面值，
%%% 否则确定栈顶字面值前合适的分隔符并将该分隔符立即写入输出缓冲区，
%%% 同时设置当前输出状态为mid.sentence
FUNCTION {output}
{ duplicate$ empty$
    'pop$
    'output.nonnull
  if$
}

%%% 读取并推出栈顶字面值，然后判断原第二栈顶字面值是否为空，
%%% 是则推出原第二栈顶字面值，并发起附带原栈顶字面值的警告信息
%%% 否则执行output.nonnull函数
%%% 相较于output函数，output.check在遇到空栈顶时会输出由用户（部分）自定义的警告信息
FUNCTION {output.check}
{ 't :=
  duplicate$ empty$
    { pop$ "empty " t * " in " * cite$ * warning$ }
    'output.nonnull
  if$
}

%%% 给栈顶元素尾部加上"."，并写入输出缓冲区，然后将输出缓冲区中的所有信息写入bbl文件
FUNCTION {fin.entry}
{ add.period$
  write$
  newline$
}


%%% 当前输出状态不是“最开始”时，将当前输出状态设置为“区块之后”
FUNCTION {new.block}
{ output.state before.all =
    'skip$
    { after.block 'output.state := }
  if$
}

%%% 当前输出状态不是“最开始”和“区块之后”时，将当前输出状态设置为“句子之后”
FUNCTION {new.sentence}
{ output.state after.block =
    'skip$
    { output.state before.all =
        'skip$
        { after.sentence 'output.state := }
      if$
    }
  if$
}

%%% 给当前栈顶字面值尾部添加空格，并设置输出状态为“最开始”
FUNCTION {add.blank}
{  " " * before.all 'output.state :=
}


FUNCTION {date.block}
{
  "," *
  add.blank
}

%%% 对栈顶元素取反，将结果压入栈顶
FUNCTION {not}
{   { #0 }
    { #1 }
  if$
}

%%% 对栈顶两元素做与运算，将结果压入栈顶
FUNCTION {and}
{   'skip$
    { pop$ #0 }
  if$
}

%%% 对栈顶两元素做或运算，将结果压入栈顶
FUNCTION {or}
{   { pop$ #1 }
    'skip$
  if$
}
STRINGS {z}

FUNCTION {remove.dots}
{ 'z :=
   ""
   { z empty$ not }
   { z #1 #2 substring$
     duplicate$ "\." =
       { z #3 global.max$ substring$ 'z :=  * }
       { pop$
         z #1 #1 substring$
         z #2 global.max$ substring$ 'z :=
         duplicate$ "." = 'pop$
           { * }
         if$
       }
     if$
   }
   while$
}
FUNCTION {new.block.checka}
{ empty$
    'skip$
    'new.block
  if$
}
FUNCTION {new.block.checkb}
{ empty$
  swap$ empty$
  and
    'skip$
    'new.block
  if$
}
FUNCTION {new.sentence.checka}
{ empty$
    'skip$
    'new.sentence
  if$
}
FUNCTION {new.sentence.checkb}
{ empty$
  swap$ empty$
  and
    'skip$
    'new.sentence
  if$
}
FUNCTION {field.or.null}
{ duplicate$ empty$
    { pop$ "" }
    'skip$
  if$
}
FUNCTION {emphasize}
{ skip$ }
FUNCTION {tie.or.space.prefix}
{ duplicate$ text.length$ #3 <
    { "~" }
    { " " }
  if$
  swap$
}

FUNCTION {capitalize}
{ "u" change.case$ "t" change.case$ }

FUNCTION {space.word}
{ " " swap$ * " " * }
 % Here are the language-specific definitions for explicit words.
 % Each function has a name bbl.xxx where xxx is the English word.
 % The language selected here is ENGLISH
FUNCTION {bbl.and}
{ "and"}

FUNCTION {bbl.etal}
{ "et~al." }

FUNCTION {bbl.deng}
{ "等" }

FUNCTION {bbl.editors}
{ "eds." }

FUNCTION {bbl.editor}
{ "ed." }

FUNCTION {bbl.edby}
{ "edited by" }

FUNCTION {bbl.edition}
{ "ed." }

FUNCTION {bbl.volume}
{ "vol." }

FUNCTION {bbl.of}
{ "of" }

FUNCTION {bbl.number}
{ "no." }

FUNCTION {bbl.nr}
{ "no." }

FUNCTION {bbl.in}
{ "in" }

FUNCTION {bbl.pages}
{ "" }

FUNCTION {bbl.page}
{ "" }

FUNCTION {bbl.chapter}
{ "chap." }

FUNCTION {bbl.techrep}
{ "Tech. Rep." }

FUNCTION {bbl.mthesis}
{ "Master's thesis" }

FUNCTION {bbl.phdthesis}
{ "Ph.D. thesis" }

FUNCTION {bbl.first}
{ "1st" }

FUNCTION {bbl.second}
{ "2nd" }

FUNCTION {bbl.third}
{ "3rd" }

FUNCTION {bbl.fourth}
{ "4th" }

FUNCTION {bbl.fifth}
{ "5th" }

FUNCTION {bbl.st}
{ "st" }

FUNCTION {bbl.nd}
{ "nd" }

FUNCTION {bbl.rd}
{ "rd" }

FUNCTION {bbl.th}
{ "th" }

MACRO {jan} {"Jan."}

MACRO {feb} {"Feb."}

MACRO {mar} {"Mar."}

MACRO {apr} {"Apr."}

MACRO {may} {"May"}

MACRO {jun} {"Jun."}

MACRO {jul} {"Jul."}

MACRO {aug} {"Aug."}

MACRO {sep} {"Sep."}

MACRO {oct} {"Oct."}

MACRO {nov} {"Nov."}

MACRO {dec} {"Dec."}

FUNCTION {eng.ord}
{ duplicate$ "1" swap$ *
  #-2 #1 substring$ "1" =
     { bbl.th * }
     { duplicate$ #-1 #1 substring$
       duplicate$ "1" =
         { pop$ bbl.st * }
         { duplicate$ "2" =
             { pop$ bbl.nd * }
             { "3" =
                 { bbl.rd * }
                 { bbl.th * }
               if$
             }
           if$
          }
       if$
     }
   if$
}

MACRO {acmcs} {"ACM Computing Surveys"}

MACRO {acta} {"Acta Informatica"}

MACRO {cacm} {"Communications of the ACM"}

MACRO {ibmjrd} {"IBM Journal of Research and Development"}

MACRO {ibmsj} {"IBM Systems Journal"}

MACRO {ieeese} {"IEEE Transactions on Software Engineering"}

MACRO {ieeetc} {"IEEE Transactions on Computers"}

MACRO {ieeetcad}
 {"IEEE Transactions on Computer-Aided Design of Integrated Circuits"}

MACRO {ipl} {"Information Processing Letters"}

MACRO {jacm} {"Journal of the ACM"}

MACRO {jcss} {"Journal of Computer and System Sciences"}

MACRO {scp} {"Science of Computer Programming"}

MACRO {sicomp} {"SIAM Journal on Computing"}

MACRO {tocs} {"ACM Transactions on Computer Systems"}

MACRO {tods} {"ACM Transactions on Database Systems"}

MACRO {tog} {"ACM Transactions on Graphics"}

MACRO {toms} {"ACM Transactions on Mathematical Software"}

MACRO {toois} {"ACM Transactions on Office Information Systems"}

MACRO {toplas} {"ACM Transactions on Programming Languages and Systems"}

MACRO {tcs} {"Theoretical Computer Science"}

%%% 检查栈顶的域是否存在，若不存在则将栈顶换成空串，否则保持原样
FUNCTION {bibinfo.check}
{ swap$
  duplicate$ missing$
    {
      pop$ pop$
      ""
    }
    { duplicate$ empty$
        {
          swap$ pop$
        }
        { swap$
          pop$
        }
      if$
    }
  if$
}

%%% 推出栈顶字面值作为信息，检查第二栈顶字面值是否是缺失的域，
%%% 是则发起包含原栈顶字面值信息的“缺失”警告，并替换原第二栈顶字面值为空字符串
%%% 否则，再检查原第二栈顶字面值是否为空，是则发起“空”警告，并保留原第二栈顶字面值成为新栈顶
FUNCTION {bibinfo.warn}
{ swap$
  duplicate$ missing$
    {
      swap$ "[Reminder] missing " swap$ * " in " * cite$ * warning$ pop$
      ""
    }
    { duplicate$ empty$
        {
          swap$ "[Reminder] empty " swap$ * " in " * cite$ * warning$
        }
        { swap$
          pop$
        }
      if$
    }
  if$
}
FUNCTION {format.eprint}
{ eprint duplicate$ empty$
    'skip$
    { "\eprint"
      archive empty$
        'skip$
        { "[" * archive * "]" * }
      if$
      "{" * swap$ * "}" *
    }
  if$
}
FUNCTION {format.url}
{
  doi empty$
    { url }
    { "http://dx.doi.org/" doi * }
  if$
  duplicate$ empty$
    { pop$ "" }
    { "\url{" swap$ * "}" * }
  if$
}
FUNCTION {remind.format.url}
{
  doi empty$
    { url }
    { "http://dx.doi.org/" doi * }
  if$
  duplicate$ empty$
    { pop$ "\textcolor{DarkRed}{[缺‘链接’信息| url域]}" }
    { "\url{" swap$ * "}" * }
  if$
}


INTEGERS { nameptr namesleft numnames }


STRINGS  { bibinfo}

FUNCTION {format.names}
{ 'bibinfo :=
  duplicate$ empty$ 'skip$ {
  's :=
  "" 't :=
  #1 'nameptr :=
  s num.names$ 'numnames :=
  numnames 'namesleft :=
    { namesleft #0 > }
    { s nameptr
      "{vv~}{ll}{ f{~}}{ jj}"
      format.name$
      remove.dots
      bibinfo bibinfo.check
      't :=
      nameptr #1 >
        {
          nameptr #3
          #1 + =
          numnames #3
          > and
            { "others" 't :=
              #1 'namesleft := }
            'skip$
          if$
          namesleft #1 >
            { ", " * t * }
            {
              s nameptr "{ll}" format.name$ duplicate$ "others" =
                { 't := }
                { pop$ }
              if$
              "," *
              t "others" =
                {
                  " " * bbl.etal *
                }
                { " " * t * }
              if$
            }
          if$
        }
        't
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$
  } if$
}
FUNCTION {format.schinese.names}
{ 'bibinfo :=
  duplicate$ empty$ 'skip$ {
  's :=
  "" 't :=
  #1 'nameptr :=
  s num.names$ 'numnames :=
  numnames 'namesleft :=
    { namesleft #0 > }
    { s nameptr
      "{vv~}{ll}{ f{~}}{ jj}"
      format.name$
      remove.dots
      bibinfo bibinfo.check
      't :=
      nameptr #1 >
        {
          nameptr #3
          #1 + =
          numnames #3
          > and
            { "others" 't :=
              #1 'namesleft := }
            'skip$
          if$
          namesleft #1 >
            { ", " * t * }
            {
              s nameptr "{ll}" format.name$ duplicate$ "others" =
                { 't := }
                { pop$ }
              if$
              "," *
              t "others" =
                {
                  " " * bbl.deng *
                }
                { " " * t * }
              if$
            }
          if$
        }
        't
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$
  } if$
}
FUNCTION {format.names.ed}
{
  format.names
}
%FUNCTION {format.authors}
%{ author "author" format.names
%}
FUNCTION {format.authors}
{
  language missing$
    { author "author" format.names }
    {
      language "schinese" =
        { author "author" format.schinese.names }
        { author "author" format.names }
      if$
    }
  if$
}
FUNCTION {format.translators}
{
  language missing$
    { translator "translator" format.names }
    {
      language "schinese" =
        { translator "translator" format.schinese.names "译" * }
        { translator "translator" format.names }
      if$
    }
  if$
}
FUNCTION {get.bbl.editor}
{ editor num.names$ #1 > 'bbl.editors 'bbl.editor if$ }

FUNCTION {format.editors}
{ editor "editor" format.names duplicate$ empty$ 'skip$
    {
      "," *
      " " *
      get.bbl.editor
      capitalize
   "(" swap$ * ")" *
      *
    }
  if$
}
FUNCTION {format.note}
{
 note empty$
    { "" }
    { note #1 #1 substring$
      duplicate$ "{" =
        'skip$
        { output.state mid.sentence =
          { "l" }
          { "u" }
        if$
        change.case$
        }
      if$
      note #2 global.max$ substring$ * "note" bibinfo.check
    }
  if$
}

FUNCTION {format.title}
{ title
  duplicate$ empty$ 'skip$
    { "t" change.case$ }
  if$
  "title" bibinfo.check
}

%%% 构建bibitem信息的开头部分，并将当前“输出状态”调整为“最开始”
FUNCTION {output.bibitem}
{ newline$
  "\bibitem{" write$
  cite$ write$
  "}" write$
  newline$
  ""
  before.all 'output.state :=
}

FUNCTION {n.dashify}
{
  't :=
  ""
    { t empty$ not }
    { t #1 #1 substring$ "-" =
        { t #1 #2 substring$ "--" = not
            { "-" *
              t #2 global.max$ substring$ 't :=
            }
            {   { t #1 #1 substring$ "-" = }
                { "-" *
                  t #2 global.max$ substring$ 't :=
                }
              while$
            }
          if$
        }
        { t #1 #1 substring$ *
          t #2 global.max$ substring$ 't :=
        }
      if$
    }
  while$
}

FUNCTION {word.in}
{ bbl.in capitalize
  " " * }

FUNCTION {format.date}
{
  month "month" bibinfo.check
  duplicate$ empty$
  year  "year"  bibinfo.check duplicate$ empty$
    { swap$ 'skip$
        { "there's a month but no year in " cite$ * warning$ }
      if$
      *
    }
    { swap$ 'skip$
        {
          " " * swap$
        }
      if$
      *
    }
  if$
  duplicate$ empty$
    'skip$
    {
      before.all 'output.state :=
    ", " swap$ *
    }
  if$
}
FUNCTION {remind.full.date}
{
  year empty$
    { "there's no year in " cite$ * warning$
      "\textcolor{DarkRed}{[缺‘年份’信息| year域]}-"
    }
    { year "-" * }
  if$
  month empty$
    { "there's no month in " cite$ * warning$ 
      "\textcolor{DarkRed}{[缺‘月份’信息| month域]}-" *
    }
    { month * "-" * }
  if$
  day empty$
    { "there's no day in " cite$ * warning$
      "\textcolor{DarkRed}{[缺‘日期’信息| day域]}" *
    }
    { day * }
  if$
}
FUNCTION {format.btitle}
{ title "title" bibinfo.check
  duplicate$ empty$ 'skip$
    {
    }
  if$
}
FUNCTION {either.or.check}
{ empty$
    'pop$
    { "can't use both " swap$ * " fields in " * cite$ * warning$ }
  if$
}
FUNCTION {format.bvolume}
{ volume empty$
    { "" }
    { bbl.volume volume tie.or.space.prefix
      "volume" bibinfo.check * *
      series "series" bibinfo.check
      duplicate$ empty$ 'pop$
        { swap$ bbl.of space.word * swap$
          emphasize * }
      if$
      "volume and number" number either.or.check
    }
  if$
}
FUNCTION {format.number.series}
{ volume empty$
    { number empty$
        { series field.or.null }
        { series empty$
            { number "number" bibinfo.check }
            { output.state mid.sentence =
                { bbl.number }
                { bbl.number capitalize }
              if$
              number tie.or.space.prefix "number" bibinfo.check * *
              bbl.in space.word *
              series "series" bibinfo.check *
            }
          if$
        }
      if$
    }
    { "" }
  if$
}
FUNCTION {is.num}
{ chr.to.int$
  duplicate$ "0" chr.to.int$ < not
  swap$ "9" chr.to.int$ > not and
}

FUNCTION {extract.num}
{ duplicate$ 't :=
  "" 's :=
  { t empty$ not }
  { t #1 #1 substring$
    t #2 global.max$ substring$ 't :=
    duplicate$ is.num
      { s swap$ * 's := }
      { pop$ "" 't := }
    if$
  }
  while$
  s empty$
    'skip$
    { pop$ s }
  if$
}

FUNCTION {convert.edition}
{ extract.num "l" change.case$ 's :=
  s "first" = s "1" = or
    { bbl.first 't := }
    { s "second" = s "2" = or
        { bbl.second 't := }
        { s "third" = s "3" = or
            { bbl.third 't := }
            { s "fourth" = s "4" = or
                { bbl.fourth 't := }
                { s "fifth" = s "5" = or
                    { bbl.fifth 't := }
                    { s #1 #1 substring$ is.num
                        { s eng.ord 't := }
                        { edition 't := }
                      if$
                    }
                  if$
                }
              if$
            }
          if$
        }
      if$
    }
  if$
  t
}

FUNCTION {format.edition}
{ edition duplicate$ empty$ 'skip$
    {
      convert.edition
      output.state mid.sentence =
        { "l" }
        { "t" }
      if$ change.case$
      "edition" bibinfo.check
      " " * bbl.edition *
    }
  if$
}
INTEGERS { multiresult }
FUNCTION {multi.page.check}
{ 't :=
  #0 'multiresult :=
    { multiresult not
      t empty$ not
      and
    }
    { t #1 #1 substring$
      duplicate$ "-" =
      swap$ duplicate$ "," =
      swap$ "+" =
      or or
        { #1 'multiresult := }
        { t #2 global.max$ substring$ 't := }
      if$
    }
  while$
  multiresult
}
FUNCTION {format.pages}
{ pages duplicate$ empty$ 'skip$
    { duplicate$ multi.page.check
        {
          n.dashify
        }
        {
        }
      if$
      "pages" bibinfo.check
    }
  if$
}
FUNCTION {remind.format.pages}
{
  pages duplicate$ empty$
    { pop$ "\textcolor{DarkRed}{[缺‘页码’信息| pages域]}" }
    { duplicate$ multi.page.check
        {
          n.dashify
        }
        {
        }
      if$
      "pages" bibinfo.check
    }
  if$
}
FUNCTION {format.journal.pages}
{ 
  remind.format.pages
  swap$ duplicate$ empty$ 'pop$
    {
      ": " *
      swap$
      *
    }
  if$
}
FUNCTION {format.journal.eid}
{ eid "eid" bibinfo.check
  duplicate$ empty$ 'pop$
    { swap$ duplicate$ empty$ 'skip$
      {
          ": " *
      }
      if$
      swap$ *
    }
  if$
}
FUNCTION {format.vol.num.pages}
{ volume field.or.null
  duplicate$ empty$ 'skip$
    {
      "volume" bibinfo.check
    }
  if$
  number "number" bibinfo.check duplicate$ empty$ 'skip$
    {
      swap$ duplicate$ empty$
        { "[Reminder] there's a number but no volume in " cite$ * warning$ }
        'skip$
      if$
      swap$
      "(" swap$ * ")" *
    }
  if$ *
}

FUNCTION {format.chapter.pages}
{ chapter empty$
    { "" }
    { type empty$
        { bbl.chapter }
        { type "l" change.case$
          "type" bibinfo.check
        }
      if$
      chapter tie.or.space.prefix
      "chapter" bibinfo.check
      * *
    }
  if$
}

FUNCTION {format.booktitle}
{
  booktitle "booktitle" bibinfo.check
}
FUNCTION {format.in.ed.booktitle}
{ format.booktitle duplicate$ empty$ 'skip$
    {
      editor "editor" format.names.ed duplicate$ empty$ 'pop$
        {
          "," *
          " " *
          get.bbl.editor
          capitalize
          "(" swap$ * ") " *
          * swap$
          * }
      if$
      %word.in swap$ *
    }
  if$
}
FUNCTION {empty.misc.check}
{ author empty$ title empty$ howpublished empty$
  month empty$ year empty$ note empty$
  and and and and and
    { "all relevant fields are empty in " cite$ * warning$ }
    'skip$
  if$
}
FUNCTION {format.thesis.type}
{ type duplicate$ empty$
    'pop$
    { swap$ pop$
      "t" change.case$ "type" bibinfo.check
    }
  if$
}
FUNCTION {format.tr.number}
{ number "number" bibinfo.check
  type duplicate$ empty$
    { pop$ bbl.techrep }
    'skip$
  if$
  "type" bibinfo.check
  swap$ duplicate$ empty$
    { pop$ "t" change.case$ }
    { tie.or.space.prefix * * }
  if$
}
FUNCTION {format.article.crossref}
{
  key duplicate$ empty$
    { pop$
      journal duplicate$ empty$
        { "need key or journal for " cite$ * " to crossref " * crossref * warning$ }
        { "journal" bibinfo.check emphasize word.in swap$ * }
      if$
    }
    { word.in swap$ * " " *}
  if$
  " \cite{" * crossref * "}" *
}
FUNCTION {format.crossref.editor}
{ editor #1 "{vv~}{ll}" format.name$
  "editor" bibinfo.check
  editor num.names$ duplicate$
  #2 >
    { pop$
      "editor" bibinfo.check
      " " * bbl.etal
      *
    }
    { #2 <
        'skip$
        { editor #2 "{ff }{vv }{ll}{ jj}" format.name$ "others" =
            {
              "editor" bibinfo.check
              " " * bbl.etal
              *
            }
            {
             bbl.and space.word
              * editor #2 "{vv~}{ll}" format.name$
              "editor" bibinfo.check
              *
            }
          if$
        }
      if$
    }
  if$
}
FUNCTION {format.book.crossref}
{ volume duplicate$ empty$
    { "empty volume in " cite$ * "'s crossref of " * crossref * warning$
      pop$ word.in
    }
    { bbl.volume
      capitalize
      swap$ tie.or.space.prefix "volume" bibinfo.check * * bbl.of space.word *
    }
  if$
  editor empty$
  editor field.or.null author field.or.null =
  or
    { key empty$
        { series empty$
            { "need editor, key, or series for " cite$ * " to crossref " *
              crossref * warning$
              "" *
            }
            { series emphasize * }
          if$
        }
        { key * }
      if$
    }
    { format.crossref.editor * }
  if$
  " \cite{" * crossref * "}" *
}
FUNCTION {format.incoll.inproc.crossref}
{
  editor empty$
  editor field.or.null author field.or.null =
  or
    { key empty$
        { format.booktitle duplicate$ empty$
            { "need editor, key, or booktitle for " cite$ * " to crossref " *
              crossref * warning$
            }
            { word.in swap$ * }
          if$
        }
        { word.in key * " " *}
      if$
    }
    { word.in format.crossref.editor * " " *}
  if$
  " \cite{" * crossref * "}" *
}
FUNCTION {format.org.or.pub}
{ 't :=
  ""
  address empty$ t empty$ and
    'skip$
    {
      address "address" bibinfo.check *
      t empty$
        'skip$
        { address empty$
            'skip$
            { ": " * }
          if$
          t *
        }
      if$
    }
  if$
}
FUNCTION {remind.publisher}
{ publisher duplicate$ empty$
    { pop$ "\textcolor{DarkRed}{[缺‘出版者’信息| publisher域]}" }
    'skip$
  if$
}
FUNCTION {format.publisher.address}
{ remind.publisher "publisher" bibinfo.warn format.org.or.pub
}

FUNCTION {remind.organization}
{ organization duplicate$ empty$
    { pop$ "\textcolor{DarkRed}{[缺‘城市, 国家’信息| organization域]}" }
    'skip$
  if$
}
FUNCTION {format.organization.address}
{ remind.organization "organization" bibinfo.check format.org.or.pub
}


FUNCTION {article}
{ output.bibitem
  format.authors "author" output.check
  new.block
  format.title "[J]" * "title" output.check
  new.block
  crossref missing$
    {
      journal
      "journal" bibinfo.check
      "journal" output.check
      year "year" output.check
      volume missing$
        {
          number missing$
            {before.all 'output.state :=}
            {date.block}
          if$
        }
        {date.block}
      if$
      format.vol.num.pages output
    }
    { format.article.crossref output.nonnull
    }
  if$
  eid empty$
    { format.journal.pages }
    { format.journal.eid }
  if$
  new.block
  format.note output
  format.eprint output
  fin.entry
}
FUNCTION {book}
{ output.bibitem
  author empty$
    { format.editors "author and editor" output.check
      add.blank
    }
    { format.authors output.nonnull
      crossref missing$
        { "author and editor" editor either.or.check }
        'skip$
      if$
    }
  if$
  new.block
  format.btitle "[M]" * "title" output.check
  new.block
  translator missing$
    {skip$}
    {
      format.translators "translator" output.check
      new.block
    }
  if$
  edition missing$
    {skip$}
    {
      language missing$
        { format.edition "edition" output.check }
        { edition "版" * "edition" output.check }
      if$
      new.block
    }
  if$
  crossref missing$
    { format.bvolume output
      new.block
      format.number.series output
      new.sentence
      format.publisher.address output
    }
    {
      new.block
      format.book.crossref output.nonnull
    }
  if$
  pages missing$
    {year "year" output.check}
    {
      year ": " * format.pages * "pages" output.check
    }
  if$
  new.block
  format.url output
  new.block
  format.note output
  format.eprint output
  fin.entry
}
FUNCTION {booklet}
{ output.bibitem
  format.authors output
  new.block
  format.title "[M]" * "title" output.check
  new.block
  howpublished "howpublished" bibinfo.check output
  address "address" bibinfo.check output
  format.date output
  new.block
  format.url output
  new.block
  format.note output
  format.eprint output
  fin.entry
}

FUNCTION {inbook}
{ output.bibitem
  author empty$
    { format.editors "author and editor" output.check
    }
    { format.authors output.nonnull
      crossref missing$
        { "author and editor" editor either.or.check }
        'skip$
      if$
    }
  if$
  new.block
  format.btitle "[M]" * "title" output.check
  crossref missing$
    {
      format.publisher.address output
      format.bvolume output
      format.chapter.pages "chapter and pages" output.check
      new.block
      format.number.series output
      new.sentence
    }
    {
      format.chapter.pages "chapter and pages" output.check
      new.block
      format.book.crossref output.nonnull
    }
  if$
  format.edition output
  format.date "year" output.check
  date.block
  format.pages "pages" output.check
  new.block
  format.url output
  new.block
  format.note output
  format.eprint output
  fin.entry
}

FUNCTION {incollection}
{ output.bibitem
  format.authors "author" output.check
  new.block
  format.title "title" output.check
  new.block
  crossref missing$
    { format.in.ed.booktitle "booktitle" output.check
      format.publisher.address output
      format.bvolume output
      format.number.series output
      format.chapter.pages output
      new.sentence
      format.edition output
    }
    { format.incoll.inproc.crossref output.nonnull
      format.chapter.pages output
    }
  if$
  format.date "year" output.check
  date.block
  format.pages "pages" output.check
  new.block
  format.url output
  new.block
  format.note output
  format.eprint output
  fin.entry
}
FUNCTION {inproceedings}
{ output.bibitem
  format.authors "author" output.check
  new.block
  format.title "[C]" * "title" output.check
  new.block
  crossref missing$
    { format.in.ed.booktitle "booktitle" output.check
      format.organization.address output
      format.bvolume output
      format.number.series output
    }
    { format.incoll.inproc.crossref output.nonnull
    }
  if$
  year ": " * remind.format.pages * "pages" output.check
  new.block
  format.note output
  format.eprint output
  fin.entry
}
FUNCTION {conference} { inproceedings }
FUNCTION {manual}
{ output.bibitem
  author empty$
    { organization "organization" bibinfo.check
      duplicate$ empty$ 'pop$
        { output
          address "address" bibinfo.check output
        }
      if$
    }
    { format.authors output.nonnull }
  if$
  new.block
  format.btitle "title" output.check
  author empty$
    { organization empty$
        {
          address new.block.checka
          address "address" bibinfo.check output
        }
        'skip$
      if$
    }
    {
      organization address new.block.checkb
      organization "organization" bibinfo.check output
      address "address" bibinfo.check output
    }
  if$
  format.edition output
  format.date output
  new.block
  format.url output
  new.block
  format.note output
  format.eprint output
  fin.entry
}

FUNCTION {mastersthesis}
{ output.bibitem
  format.authors "author" output.check
  new.block
  format.title "[D]" * "title" output.check
  new.block
  address "address" bibinfo.warn output
  ": " * write$
  school "school" bibinfo.warn
  pages missing$
    {
      pages "pages" bibinfo.warn pop$
      year "year" output.check
    }
    {year ": " * format.pages * "pages" output.check}
  if$
  new.block
  format.url output
  new.block
  format.note output
  format.eprint output
  fin.entry
}

FUNCTION {phdthesis}
{ output.bibitem
  format.authors "author" output.check
  new.block
  format.title "[D]" *
  "title" output.check
  new.block
  address "address" bibinfo.warn output
  ": " * write$
  school "school" bibinfo.warn
  pages missing$
    {
      pages "pages" bibinfo.warn pop$
      year "year" output.check
    }
    {year ": " * format.pages * "pages" output.check}
  if$
  new.block
  format.url output
  new.block
  format.note output
  format.eprint output
  fin.entry
}

FUNCTION {proceedings}
{ output.bibitem
  editor empty$
    { organization "organization" bibinfo.check output
    }
    { format.editors output.nonnull }
  if$
  new.block
  format.btitle "[C]" * "title" output.check
  format.bvolume output
  format.number.series output
  editor empty$
    { publisher empty$
        'skip$
        {
          new.sentence
          format.publisher.address output
        }
      if$
    }
    { publisher empty$
        {
          new.sentence
          format.organization.address output }
        {
          new.sentence
          organization "organization" bibinfo.check output
          format.publisher.address output
        }
      if$
     }
  if$
      year "year" output.check
  new.block
  format.note output
  format.eprint output
  fin.entry
}

FUNCTION {news}
{ output.bibitem
  format.authors "author" output.check
  new.block
  format.title "[N]" * "title" output.check
  new.block
  remind.publisher "publisher" bibinfo.warn output
  remind.full.date "date" bibinfo.warn output write$
  number duplicate$ empty$
    { pop$ "\textcolor{DarkRed}{[缺‘版号’信息| number域]}" }
    'skip$
  if$
  " (" swap$ * ")" *
  new.block
  format.url output
  new.block
  format.note output
  format.eprint output
  fin.entry
}

FUNCTION {report}
{ output.bibitem
  format.authors "author" output.check
  new.block
  format.title "[R]" *
  "title" output.check
  new.block
  address "address" bibinfo.warn output
  ": " *  write$
  remind.publisher "publisher" bibinfo.warn
  year "year" output.check
  new.block
  format.url output
  new.block
  format.note output
  format.eprint output
  fin.entry
}

FUNCTION {unpublished}
{ output.bibitem
  format.authors "author" output.check
  new.block
  format.title "title" output.check
  format.date output
  new.block
  format.url output
  new.block
  format.note "note" output.check
  format.eprint output
  fin.entry
}

FUNCTION {patent}
{ output.bibitem
  format.authors "author" output.check
  new.block
  format.title ": " * number * "[P]" * "title" output.check
  new.block
  crossref missing$
    { remind.full.date "fulldate" output.check }
    { format.article.crossref output.nonnull }
  if$
  new.block
  format.url output
  new.block
  format.note output
  format.eprint output
  fin.entry
}

FUNCTION {remind.year}
{ year duplicate$ empty$
   { pop$ "\textcolor{DarkRed}{[缺‘年份’信息| year域]}" }
   'skip$
  if$
}
FUNCTION {standard}
{ output.bibitem
  format.authors "author" output.check
  new.block
  format.title ": " * number * "[S]" * "title" output.check
  new.block
  address "address" bibinfo.warn output
  ": " * write$
  remind.publisher "publisher" bibinfo.warn
  remind.year ": " * remind.format.pages * "year" output.check
  new.block
  format.url output
  new.block
  format.note output
  format.eprint output
  fin.entry
}

FUNCTION {remind.modifydate}
{ modifydate duplicate$ empty$
   { pop$ "\textcolor{DarkRed}{[缺‘修改日期’信息| modifydate域]}" }
   'skip$
  if$
}
FUNCTION {remind.citedate}
{ citedate duplicate$ empty$
   { pop$ "\textcolor{DarkRed}{[缺‘引用日期’信息| citedate域]}" }
   'skip$
  if$
}
FUNCTION {digital}
{ output.bibitem
  format.authors "author" output.check
  new.block
  format.title "[" * type * "]" * "title" output.check
  new.block
  address missing$
    { remind.modifydate "modifydate" bibinfo.warn output }
    {
      address "address" bibinfo.warn output
      ": " * write$
      remind.publisher "publisher" bibinfo.warn
      year "year" bibinfo.warn output
      ": " * write$
      remind.format.pages "pages" bibinfo.warn write$
      remind.modifydate "modifydate" bibinfo.warn
      " (" swap$ * ")" * write$
      remind.citedate "citedate" bibinfo.warn
      " [" swap$ * "]" *
      new.block
    }
  if$
  remind.format.url output
  fin.entry
}

FUNCTION {misc}
{ output.bibitem
  format.authors output
  title howpublished new.block.checkb
  format.title output
  howpublished new.block.checka
  howpublished "howpublished" bibinfo.check output
  format.date output
  new.block
  format.url output
  new.block
  format.note output
  format.eprint output
  fin.entry
  empty.misc.check
}

FUNCTION {default.type} { misc }
READ
STRINGS { longest.label }
INTEGERS { number.label longest.label.width }
FUNCTION {initialize.longest.label}
{ "" 'longest.label :=
  #1 'number.label :=
  #0 'longest.label.width :=
}
FUNCTION {longest.label.pass}
{ number.label int.to.str$ 'label :=
  number.label #1 + 'number.label :=
  label width$ longest.label.width >
    { label 'longest.label :=
      label width$ 'longest.label.width :=
    }
    'skip$
  if$
}
EXECUTE {initialize.longest.label}
ITERATE {longest.label.pass}
FUNCTION {begin.bib}
{ preamble$ empty$
    'skip$
    { preamble$ write$ newline$ }
  if$
  "\begin{thebibliography}{"  longest.label  * "}" *
  write$ newline$
  "\providecommand{\url}[1]{\texttt{#1}}"
  write$ newline$
  "\providecommand{\urlprefix}{URL }"
  write$ newline$
  "\providecommand{\eprint}[2][]{\url{#2}}"
  write$ newline$
}
EXECUTE {begin.bib}
EXECUTE {init.state.consts}
ITERATE {call.type$}
FUNCTION {end.bib}
{ newline$
  "\end{thebibliography}" write$ newline$
}
EXECUTE {end.bib}
%% End of customized bst file
%%
%% End of file `DissertUESTC.bst'.
