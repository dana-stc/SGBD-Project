drop table conturi cascade constraints;
drop table mese cascade constraints;
drop table categorii cascade constraints;
drop table produse cascade constraints;
drop table leg_cat_prod cascade constraints;
drop table leg_stoc cascade constraints;
drop table comenzi cascade constraints;
drop table incasari cascade constraints;
drop table istoric cascade constraints;

create table conturi
(
  id_cont number(3) primary key,
  utilizator varchar2(30) not null unique,
  parola varchar2(30) not null,
  isAdmin number(1)  
);
create table mese
(
  id_masa number(5) primary key,
  numar number(3) not null unique,
  status varchar2(30) not null,
  data_rezervare timestamp,
  mentiune varchar2(100)
);
create table categorii
(
  id_categorie number(5) primary key,
  nume varchar2(30) not null
);
create table produse
(
  id_produs number(11) primary key,  
  nume_produs varchar2(50) not null,
  pret float not null,
  descriere varchar2(100)  
);
create table leg_cat_prod
(
    id_produs number(11) not null,
    id_categorie number(5) not null,
    constraint leg_cat_prod_pk primary key (id_produs,id_categorie),
    foreign key(id_produs) references produse(id_produs),
    foreign key(id_categorie) references categorii(id_categorie)
);

create table leg_stoc
(    
    id_produs number(11) not null,
    stoc number(10) null,
    constraint leg_stoc_pk primary key (id_produs),
    foreign key(id_produs) references produse(id_produs)
);

create table comenzi
(
  id_comanda number(10) primary key,
  numar_masa number(5) not null,
  id_produs number(11) not null,
  cantitate number(5) not null,
  pret float not null,
  data_comanda date not null,
  foreign key(numar_masa) references mese(numar),
  foreign key(id_produs) references produse(id_produs)
);

create table incasari
(
  id number(10) primary key,
  id_produs number(11) not null,
  nume_produs varchar2(50) not null,
  cantitate number(5) not null,
  pret float not null,
  data_incasare timestamp not null,
  foreign key(id_produs) references produse(id_produs)
);

create table istoric
(
  id number(10) primary key,
  utilizator varchar2(30) not null,
  comanda varchar2(50) not null,
  numar_masa number(5) not null,
  pret_comanda float not null,
  data timestamp not null,
  foreign key(utilizator) references conturi(utilizator),
  foreign key(numar_masa) references mese(numar)
);

declare
  type vector is varray(9000000) of varchar2(40);
  --generated with: https://jimpix.co.uk/words/random-username-list.asp
  username_list vector := vector('icerinkpetal','spendduffel','tidoneighbour','bridledjupe','particlesfraser','surroundmisty','listenersimmature','likabletourist','bibesyfavored','ferociousbuckwheat','simplifygold','acneequinox','digitinvoice','barbedwarkened','brillounmixed','folksupply','blogwade','spearfishpenguin','bobbingtemporary','acousticscityscape','cheeksterteacher','flickslap','flypapermozart','frilluntruth','swunababy','yawlabydocomist','tattooedsoft','retiredhal','carbloodhound','flourthroot','convexatop','sophytransit','radarcrogs','deatbaffle','admissionsmccue','uninvitedforses','drumbuzz','majorunit','spearmintcamera','frontsteam','sammyatticus','drowsilyrefresh','visitmammoth','dazzlehoors','octaveresource','districtblinker','bigyesterday','peopleluxury','wycollercauliflower','croakcolumn','beaverarm','sipstratford','urinalchunching','quagswagginghutley','upscalestarboard','unionsextans','flossededmund','spoutstirring','vinomadefiedgangs','superbseat','wheeringhamilton','pintdepravity','dialsector','sleepyglisten','triedcured','featureresistant','buretspouse','blokepork','flairheadprayer','psychoticdenali','liquidimpala','untamedamy','inverietiling','travelarena','erasureyaldson','bellingtonunabashed','radiatemisty','thappingtrickle','dubniummassan','upholditinerary','expectantprepare','erlenmeyermessaging','karateshine','frenzyseverance','reducecoach','smobkept','yumstored','bansheeventure','amplifieraleph','expressionbrabble','tulipfiery','citygranger','gormlessdurably','jawedfoggy','trottyturn','snortveto','eliecstatic','heydenquantum','yellowknifecassley','sedimentwaggaford','icecreampager','shasticbullish','fernstrict','automaticcovalent','vancouvermarco','sullivantrident','effecturethane','ceramicsthicken','nurseryclaptrap','upwardnorm','databasescorn','dwarfhedgehog','capsizeuniversity','resonantroasted','uniquelypride','assbollard','deodorantthallium','kidneysadmissions','chappedyellow','passagerunie','aloftheinz','lifesownds','polocleo','cotconstant','coladoudy','plannerflora','gracefulapron','zigzagchalice','fredgush','grimwigtruck','stonesjersey','brookstorridon','diagramcurled','fieldingcapsule','uniformedunpaved','alliedgithub','despairhird','batmanlying','smugint','touchyblockson','nutshellhurt','defectivejuicy','yoghurtephraim','nairobirectify','goodbutthead','opportunitystature','lukewarmcramp','wrestlerift','conventmulch','imprintdisobey','unpaddedclinking','jibexonerate','laserizzy','turbulenttrash','dindycurd','homeplatebirdie','pryrinsing','veinwhittle','universitypayback','doedamage','artisticdiagnostic','walkerexcretory','shelvinggrayper','violenteducate','headphonesgoldmine','floridaafternoon','sundanceretro','jetharpist','hornbillprism','stimulantbakery','yukonskall','oxidationlash','preciousbath','italiannecked','deakysatisfied','cheaperrascal','genericsilicon','whimpleascent','requestscalm','gifteven','amoebaissuing','soulfulrefresh','mountingstrain','implicitrumble','luineagscaked','songscenic','dimensionhicken','illfatedmousy','coronaryfantasize','satinshawna','obligationholy','achinesslady','generousfellowship','atomkeystone','rotatingjet','tinselfifth','ownbisector','fixturerotation','pogofloss','slatepond');
  first_name_list vector := vector('Bonnie','Louise','Janet','Anna','Jane','Ruth','Ashley','Tina','Joyce','Stephanie','Laura','Virginia','Alice','Margaret','Lori','Sharon','Anne','Emily','Andrea','Elizabeth','Sarah','Rebecca','Ann','Brenda','Jessica','Paula','Jennifer','Diana','Cheryl','Lois','Teresa','Susan','Evelyn','Karen','Wanda','Gloria','Carol','Nicole','Phyllis','Martha','Carolyn','Denise','Heather','Theresa','Marie','Sara','Doris','Cynthia','Joan','Sandra','Kathryn','Julie','Mildred','Jacqueline','Donna','Rose','Dorothy','Debra','Rachel','Diane','Irene','Helen','Jean','Lillian','Patricia','Norma','Kelly','Janice','Frances','Annie','Christine','Michelle','Beverly','Catherine','Melissa','Judith','Lisa','Pamela','Tammy','Kathy','Deborah','Linda','Judy','Kathleen','Angela','Christina','Katherine','Marilyn','Shirley','Maria','Ruby','Mary','Kimberly','Barbara','Nancy','Betty','Amy','Julia','Amanda','Alonzo','Lorenzo','Tommy','Levi','Dustin','Angelo','Matthew','Johnny','Andres','Jeffrey','Samuel','Alberto','Leland','Wallace','Loren','Gustavo','Virgil','Dale','Jaime','Gerard','Carlos','Jason','Roy','Harvey','Willard','Rick','Stuart','Cody','Eduardo','Gerardo','Curtis','Aubrey','Sammy','Gene','Toby','Winston','Tony','Charlie','Wm','Joseph','Marty','Johnnie','Earl','Brad','Jonathan','Rex','Cornelius','Eddie','Cesar','Keith','Louis','Micheal','Nicholas','Dwight','Dave','Rodolfo','Warren','Raymond','Shannon','Emmett','George','Moses','Preston','Guillermo','Andrew','Ignacio','Leslie','Ian','Kirk','Amos','Bert','Ronnie','Timmy','Manuel','Tim','Gregory','Mario','Earnest','Luis','Lawrence','Eric','Miguel','Rudy','Albert','Wayne','Colin','Larry','Israel','Salvador','Jorge','Thomas','Alton','Pat','Malcolm','Randolph','Nicolas','Marshall','Francis','Tyrone','Lewis');
  status_mese_list vector := vector('disponibila','ocupata','rezervata');
  categorii_list vector := vector('bauturi carbogazoase','bauturi necarbogazoase','fresh-uri','pizza','ciorbe','vin','delicatese','cina','mic dejun','pranz','prajituri','clatite','oferte','altele','paste');  
  
  bauturi_carbogazoase_list vector := vector('sprite','fanta','coca-cola','coca-cola no sugar','coca cola MAX','coca-cola lime','pepsi','pepsi twist','pepsi lime','pepsi no sugar','pepsi MAX','schweppes','adria','dorna','borsec');
  bauturi_necarbogazoase_list vector := vector('cappy','pulpy','limonada','borsec','dorna','tymbark','perla harghitei','aqua carpatica');  
  cantitate_bautura_list vector := vector('250ml','500ml','750ml','1L','1.25L','1.5L','2L','2.5L');
  freshuri_list vector := vector('suc de portocale','suc de lamaie','socata','fresh de graphfruit cu ananas','suc de telina','smoothie de kiwi cu banane','smoothie de afine','smoothie de pepene','milkshake de pepene','bautura aurie cu iaurt');
  pizza_list vector := vector('pizza de post','pizza Margherita','pizza Prosciutto cotto','pizza Salami','pizza Diavola','pizza Vegetariana','pizza Prosciutto e funghi','pizza Capriciosa','pizza Quattro Stagioni','pizza Quattro Carni','pizza Hawaii','pizza Tonno','pizza Pollo','pizza Royala','pizza Bacon','pizza Rustica','pizza Quattro Formagi','pizza Prosciutto Crudo','pizza Delicio','pizza Mamma-Mia','pizza Bistro','pizza Party');
  ciorbe_list vector := vector('ciorba de legume','ciorba de burta','ciorba de pui','ciorba de porc','ciorba de peste','ciorba de vita','ciorba de vacuta','ciorba de perisoare','ciorba de fasole','ciorba radauteana','ciorba ardeleneasca');
    
  adjective_list vector := vector('abandoned','able','absolute','adorable','adventurous','academic','acceptable','acclaimed','accomplished','accurate','aching','acidic','acrobatic','active','actual','adept','admirable','admired','adolescent','adorable','adored','advanced','afraid','affectionate','aged','aggravating','aggressive','agile','agitated','agonizing','agreeable','ajar','alarmed','alarming','alert','alienated','alive','all','altruistic','amazing','ambitious','ample','amused','amusing','anchored','ancient','angelic','angry','anguished','animated','annual','another','antique','anxious','any','apprehensive','appropriate','apt','arctic','arid','aromatic','artistic','ashamed','assured','astonishing','athletic','attached','attentive','attractive','austere','authentic','authorized','automatic','avaricious','average','aware','awesome','awful','awkward','babyish','bad','back','baggy','bare','barren','basic','beautiful','belated','beloved','beneficial','better','best','bewitched','big','big-hearted','biodegradable','bite-sized','bitter','black','black-and-white','bland','blank','blaring','bleak','blind','blissful','blond','blue','blushing','bogus','boiling','bold','bony','boring','bossy','both','bouncy','bountiful','bowed','brave','breakable','brief','bright','brilliant','brisk','broken','bronze','brown','bruised','bubbly','bulky','bumpy','buoyant','burdensome','burly','bustling','busy','buttery','buzzing','calculating','calm','candid','canine','capital','carefree','careful','careless','caring','cautious','cavernous','celebrated','charming','cheap','cheerful','cheery','chief','chilly','chubby','circular','classic','clean','clear','clear-cut','clever','close','closed','cloudy','clueless','clumsy','cluttered','coarse','cold','colorful','colorless','colossal','comfortable','common','compassionate','competent','complete','complex','complicated','composed','concerned','concrete','confused','conscious','considerate','constant','content','conventional','cooked','cool','cooperative','coordinated','corny','corrupt','costly','courageous','courteous','crafty','crazy','creamy','creative','creepy','criminal','crisp','critical','crooked','crowded','cruel','crushing','cuddly','cultivated','cultured','cumbersome','curly','curvy','cute','cylindrical','damaged','damp','dangerous','dapper','daring','darling','dark','dazzling','dead','deadly','deafening','dear','dearest','decent','decimal','decisive','deep','defenseless','defensive','defiant','deficient','definite','definitive','delayed','delectable','delicious','delightful','delirious','demanding','dense','dental','dependable','dependent','descriptive','deserted','detailed','determined','devoted','different','difficult','digital','diligent','dim','dimpled','dimwitted','direct','disastrous','discrete','disfigured','disgusting','disloyal','dismal','distant','downright','dreary','dirty','disguised','dishonest','dismal','distant','distinct','distorted','dizzy','dopey','doting','double','downright','drab','drafty','dramatic','dreary','droopy','dry','dual','dull','dutiful','each','eager','earnest','early','easy','easy-going','ecstatic','edible','educated','elaborate','elastic','elated','elderly','electric','elegant','elementary','elliptical','embarrassed','embellished','eminent','emotional','empty','enchanted','enchanting','energetic','enlightened','enormous','enraged','entire','envious','equal','equatorial','essential','esteemed','ethical','euphoric','even','evergreen','everlasting','every','evil','exalted','excellent','exemplary','exhausted','excitable','excited','exciting','exotic','expensive','experienced','expert','extraneous','extroverted','extra-large','extra-small','fabulous','failing','faint','fair','faithful','fake','false','familiar','famous','fancy','fantastic','far','faraway','far-flung','far-off','fast','fat','fatal','fatherly','favorable','favorite','fearful','fearless','feisty','feline','female','feminine','few','fickle','filthy','fine','finished','firm','first','firsthand','fitting','fixed','flaky','flamboyant','flashy','flat','flawed','flawless','flickering','flimsy','flippant','flowery','fluffy','fluid','flustered','focused','fond','foolhardy','foolish','forceful','forked','formal','forsaken','forthright','fortunate','fragrant','frail','frank','frayed','free','French','fresh','frequent','friendly','frightened','frightening','frigid','frilly','frizzy','frivolous','front','frosty','frozen','frugal','fruitful','full','fumbling','functional','funny','fussy','fuzzy','gargantuan','gaseous','general','generous','gentle','genuine','giant','giddy','gigantic','gifted','giving','glamorous','glaring','glass','gleaming','gleeful','glistening','glittering','gloomy','glorious','glossy','glum','golden','good','good-natured','gorgeous','graceful','gracious','grand','grandiose','granular','grateful','grave','gray','great','greedy','green','gregarious','grim','grimy','gripping','grizzled','gross','grotesque','grouchy','grounded','growing','growling','grown','grubby','gruesome','grumpy','guilty','gullible','gummy','hairy','half','handmade','handsome','handy','happy','happy-go-lucky','hard','hard-to-find','harmful','harmless','harmonious','harsh','hasty','hateful','haunting','healthy','heartfelt','hearty','heavenly','heavy','hefty','helpful','helpless','hidden','hideous','high','high-level','hilarious','hoarse','hollow','homely','honest','honorable','honored','hopeful','horrible','hospitable','hot','huge','humble','humiliating','humming','humongous','hungry','hurtful','husky','icky','icy','ideal','idealistic','identical','idle','idiotic','idolized','ignorant','ill','illegal','ill-fated','ill-informed','illiterate','illustrious','imaginary','imaginative','immaculate','immaterial','immediate','immense','impassioned','impeccable','impartial','imperfect','imperturbable','impish','impolite','important','impossible','impractical','impressionable','impressive','improbable','impure','inborn','incomparable','incompatible','incomplete','inconsequential','incredible','indelible','inexperienced','indolent','infamous','infantile','infatuated','inferior','infinite','informal','innocent','insecure','insidious','insignificant','insistent','instructive','insubstantial','intelligent','intent','intentional','interesting','internal','international','intrepid','ironclad','irresponsible','irritating','itchy','jaded','jagged','jam-packed','jaunty','jealous','jittery','joint','jolly','jovial','joyful','joyous','jubilant','judicious','juicy','jumbo','junior','jumpy','juvenile','kaleidoscopic','keen','key','kind','kindhearted','kindly','klutzy','knobby','knotty','knowledgeable','knowing','known','kooky','kosher','lame','lanky','large','last','lasting','late','lavish','lawful','lazy','leading','lean','leafy','left','legal','legitimate','light','lighthearted','likable','likely','limited','limp','limping','linear','lined','liquid','little','live','lively','livid','loathsome','lone','lonely','long','long-term','loose','lopsided','lost','loud','lovable','lovely','loving','low','loyal','lucky','lumbering','luminous','lumpy','lustrous','luxurious','mad','made-up','magnificent','majestic','major','male','mammoth','married','marvelous','masculine','massive','mature','meager','mealy','mean','measly','meaty','medical','mediocre','medium','meek','mellow','melodic','memorable','menacing','merry','messy','metallic','mild','milky','mindless','miniature','minor','minty','miserable','miserly','misguided','misty','mixed','modern','modest','moist','monstrous','monthly','monumental','moral','mortified','motherly','motionless','mountainous','muddy','muffled','multicolored','mundane','murky','mushy','musty','muted','mysterious','naive','narrow','nasty','natural','naughty','nautical','near','neat','necessary','needy','negative','neglected','negligible','neighboring','nervous','new','next','nice','nifty','nimble','nippy','nocturnal','noisy','nonstop','normal','notable','noted','noteworthy','novel','noxious','numb','nutritious','nutty','obedient','obese','oblong','oily','oblong','obvious','occasional','odd','oddball','offbeat','offensive','official','old','old-fashioned','only','open','optimal','optimistic','opulent','orange','orderly','organic','ornate','ornery','ordinary','original','other','our','outlying','outgoing','outlandish','outrageous','outstanding','oval','overcooked','overdue','overjoyed','overlooked','palatable','pale','paltry','parallel','parched','partial','passionate','past','pastel','peaceful','peppery','perfect','perfumed','periodic','perky','personal','pertinent','pesky','pessimistic','petty','phony','physical','piercing','pink','pitiful','plain','plaintive','plastic','playful','pleasant','pleased','pleasing','plump','plush','polished','polite','political','pointed','pointless','poised','poor','popular','portly','posh','positive','possible','potable','powerful','powerless','practical','precious','present','prestigious','pretty','precious','previous','pricey','prickly','primary','prime','pristine','private','prize','probable','productive','profitable','profuse','proper','proud','prudent','punctual','pungent','puny','pure','purple','pushy','putrid','puzzled','puzzling','quaint','qualified','quarrelsome','quarterly','queasy','querulous','questionable','quick','quick-witted','quiet','quintessential','quirky','quixotic','quizzical','radiant','ragged','rapid','rare','rash','recent','reckless','rectangular','ready','realistic','reasonable','red','reflecting','regal','reliable','relieved','remarkable','remorseful','remote','repentant','respectful','responsible','repulsive','revolving','rewarding','rich','rigid','right','ringed','ripe','roasted','robust','rosy','rotating','rotten','rough','round','rowdy','royal','rubbery','rundown','ruddy','rude','runny','rural','rusty','sad','safe','salty','same','sandy','sane','sarcastic','sardonic','satisfied','scaly','scarce','scared','scary','scented','scholarly','scientific','scornful','scratchy','scrawny','second','secondary','second-hand','secret','self-assured','self-reliant','selfish','sentimental','separate','serene','serious','serpentine','several','severe','shabby','shadowy','shady','shallow','shameful','shameless','sharp','shimmering','shiny','shocked','shocking','shoddy','short','short-term','showy','shrill','shy','sick','silent','silky','silly','silver','similar','simple','simplistic','sinful','single','sizzling','skeletal','skinny','sleepy','slight','slim','slimy','slippery','slow','slushy','small','smart','smoggy','smooth','smug','snappy','snarling','sneaky','sniveling','snoopy','sociable','soft','soggy','solid','somber','some','spherical','sophisticated','sore','sorrowful','soulful','soupy','sour','Spanish','sparkling','sparse','specific','spectacular','speedy','spicy','spiffy','spirited','spiteful','splendid','spotless','spotted','spry','square','squeaky','squiggly','stable','staid','stained','stale','standard','starchy','stark','starry','steep','sticky','stiff','stimulating','stingy','stormy','straight','strange','steel','strict','strident','striking','striped','strong','studious','stunning','stupendous','stupid','sturdy','stylish','subdued','submissive','substantial','subtle','suburban','sudden','sugary','sunny','super','superb','superficial','superior','supportive','sure-footed','surprised','suspicious','svelte','sweaty','sweet','sweltering','swift','sympathetic','tall','talkative','tame','tan','tangible','tart','tasty','tattered','taut','tedious','teeming','tempting','tender','tense','tepid','terrible','terrific','testy','thankful','that','these','thick','thin','third','thirsty','this','thorough','thorny','those','thoughtful','threadbare','thrifty','thunderous','tidy','tight','timely','tinted','tiny','tired','torn','total','tough','traumatic','treasured','tremendous','tragic','trained','tremendous','triangular','tricky','trifling','trim','trivial','troubled','true','trusting','trustworthy','trusty','truthful','tubby','turbulent','twin','ugly','ultimate','unacceptable','unaware','uncomfortable','uncommon','unconscious','understated','unequaled','uneven','unfinished','unfit','unfolded','unfortunate','unhappy','unhealthy','uniform','unimportant','unique','united','unkempt','unknown','unlawful','unlined','unlucky','unnatural','unpleasant','unrealistic','unripe','unruly','unselfish','unsightly','unsteady','unsung','untidy','untimely','untried','untrue','unused','unusual','unwelcome','unwieldy','unwilling','unwitting','unwritten','upbeat','upright','upset','urban','usable','used','useful','useless','utilized','utter','vacant','vague','vain','valid','valuable','vapid','variable','vast','velvety','venerated','vengeful','verifiable','vibrant','vicious','victorious','vigilant','vigorous','villainous','violet','violent','virtual','virtuous','visible','vital','vivacious','vivid','voluminous','wan','warlike','warm','warmhearted','warped','wary','wasteful','watchful','waterlogged','watery','wavy','wealthy','weak','weary','webbed','wee','weekly','weepy','weighty','weird','welcome','well-documented','well-groomed','well-informed','well-lit','well-made','well-off','well-to-do','well-worn','wet','which','whimsical','whirlwind','whispered','white','whole','whopping','wicked','wide','wide-eyed','wiggly','wild','willing','wilted','winding','windy','winged','wiry','wise','witty','wobbly','woeful','wonderful','wooden','woozy','wordy','worldly','worn','worried','worrisome','worse','worst','worthless','worthwhile','worthy','wrathful','wretched','writhing','wrong','wry','yawning','yearly','yellow','yellowish','young','youthful','yummy','zany','zealous','zesty','zigzag');      
  last_name_list vector := vector('Morrison','Bennett','Brady','Coleman','Ford','Rios','Poole','Walters','Guerrero','Flores','Lee','Miller','Francis','French','Martin','Sherman','Graham','Garner','Maxwell','Estrada','Morales','Owen','Lawson','Benson','Hammond','Greene','Lamb','Castro','Perkins','Hughes','Barnes','Mckenzie','Watts','Anderson','Gregory','Alvarez','Yates','Fowler','Wilkins','Warren','Burns','Boone','Goodwin','Porter','Wheeler','Brock','Howard','Barton','Zimmerman','Hodges','Massey','Norton','Gibson','Strickland','Bell','Robinson','Graves','Craig','Howell','Hunt','Malone','Richards','Murphy','Nash','West','Lloyd','Paul','Fuller','Holloway','Goodman','Ryan','Reeves','Cole','Parker','Cohen','Ingram','Scott','Byrd','Hart','Casey','Franklin','Morgan','Mclaughlin','Lyons','Montgomery','Stephens','Glover','Roberts','Erickson','Allison','Ramos','Holland','Hawkins','Williamson','Edwards','Mccoy','Swanson','Delgado','Ellis','Collins','Boyd','Myers','Nichols','Wood','Rice','Wolfe','Stokes','Ortiz','Haynes','Mccormick','Norman','Knight','Patton','Gomez','Chandler','Henry','Tucker','Kennedy','Day','Gray','Banks','Allen','Clark','Reed','Oliver','Price','Simon','Fox','Copeland','Harrington','Brooks','Ruiz','Taylor','Griffith','Jordan','Ballard','Clarke','Kelley','Waters','Russell','Luna','Becker','Nguyen','Norris','Munoz','Wilson','Todd','Olson','George','Rivera','Williams','White','Torres','Brewer','Mendoza','Alexander','Joseph','Mason','Webster','Higgins','Barnett','Harrison','Bailey','Underwood','Robertson','Watkins','Stone','Quinn','Hicks','Holt','Burgess','Hoffman','Adams','Stevens','Chavez','Wilkerson','Bryan','Sandoval','Greer','Soto','Walsh','Wagner','Vega','Schmidt','Figueroa','Thornton','Diaz','Hamilton','Peters','Sims','Duncan','Rhodes','Carter','Alvarado','Powell','Burton','Osborne','Blake','Palmer','Moore','Dawson','Henderson','Lowe','Peterson','Sanders','Shelton','Lopez','Mckinney','Ferguson','Pierce','Neal','Abbott','Keller','Silva','Stewart','Griffin','Lynch','Bush','Nelson','Townsend','Butler','Webb','Spencer','Mack','Frazier','Gutierrez','Moody','Carroll','Bowman','Little','Guzman','Martinez','Larson','Clayton','Perez','Colon','Daniel','Adkins','Turner','Smith','Tate','Mccarthy','Douglas','Riley','Mills','Briggs','Collier','Perry','Murray','Mullins','Vasquez','Wright','Pearson','Cooper','Lewis','Foster','Mann','Santiago','Santos','Cain','Rodgers','Lambert','Fitzgerald','Hudson','Fletcher','Jennings','Schultz','Bowen','Schwartz','Rose','Hopkins','Doyle','Carr','Saunders','Meyer','Cruz','Roy','Baker','Simpson','Valdez','Newton','Caldwell','Parks','Obrien','Johnson','Weaver','Steele','Thomas','Fisher','Walker','Johnston','Grant','Watson','Reid','Gill','Carson','Simmons','Barrett','Holmes','Wells','Mcdonald','Garza','Cook','Bridges','Cox','Leonard','Klein','Lawrence','Rowe','Quinnteles','Aguilar','Willis','Harmon','Long','Davis','Summers','Davidson','Baldwin','Harper','Patrick','Sanchez','Gonzalez','Lindsey','Miles','Wise','Roberson','Bass','Mcgee','Powers','Richardson','Nunez','Hogan','Gordon','Singleton','Harvey','Wade','Welch','Kelly','Houston','Sutton','Love','Bradley','Jimenez','Floyd','Ortega','Black','Ball','Crawford','Bowers','Hernandez','Tran','Brown','Armstrong','Gilbert','Cummings','Snyder','Hayes','Padilla','Dixon','Hampton','Mathis','Medina','Jenkins','Hill','Jacobs','King','Jefferson','Conner','Chapman','Terry','Christensen','Maldonado','Stanley','Gardner','Fields','Ward','Hunter','Ross','Cannon','Sharp','Manning','Newman','Mitchell','Morris','Morton','Hansen','Ramsey','Garcia','Moss','Vargas','Hale','Wallace','Dennis','Fernandez','Thompson','Huff','Park','Walton','Kim','Chambers');
  
  --Source: https://profs.info.uaic.ro/~bd/wiki/index.php/Pagina_principal%C4%83

  --CONTURI
  v_utilizator varchar2(30);
  v_parola varchar2(30);
  v_exista int := 1;
  --MESE
  v_statusMasa varchar2(30);  
  v_mentiuneRezervareMasa varchar2(100);  
  --PRODUSE
  v_numeProdus varchar2(50);
  v_pretProdus float;
  v_descriereProdus varchar2(100);
  v_rndNumber int;
  v_stocLimitatProdus number(1);
  v_stocProdus number(5);
  v_rndCateg number(2);
  v_cantitate number(2);
  --COMENZI
  v_idComanda number(5);
  v_nrMasa number(3);
  --INCASARI
  v_data varchar2(50);
  vector_utilizatori vector;
begin
  --CONTURI (20)
  DBMS_OUTPUT.PUT_LINE('---Inserarea a 20 de CONTURI---');
  for i in 1..20 loop
      while v_exista = 1 loop
        v_utilizator := username_list(trunc(DBMS_RANDOM.VALUE(0,username_list.count))) || trunc(DBMS_RANDOM.VALUE(0,100));
        if(length(v_utilizator) > 30) then
            v_utilizator := substr(v_utilizator, 1, 30);
        end if;
        select count(*) into v_exista from conturi where utilizator = v_utilizator;
      end loop;
      
      v_parola := username_list(trunc(DBMS_RANDOM.VALUE(0,username_list.count)));
      if(length(v_parola) > 30) then
            v_parola := substr(v_parola, 1, 30);
      end if;
      insert into conturi(id_cont,utilizator,parola,isadmin) values(i,v_utilizator,v_parola,DBMS_RANDOM.VALUE(0,1));      
      v_exista := 1;
  end loop;
  insert into conturi(id_cont,utilizator,parola,isadmin) values(21,'admin','admin0',1);      
  insert into conturi(id_cont,utilizator,parola,isadmin) values(22,'user0','password0',0);
    
  --MESE (50)
  DBMS_OUTPUT.PUT_LINE('---Inserarea a 50 de MESE---');
  for i in 1..50 loop      
    v_statusMasa := status_mese_list(DBMS_RANDOM.VALUE(1,status_mese_list.count));
    if(v_statusMasa = 'rezervata') then      
        v_mentiuneRezervareMasa := first_name_list(DBMS_RANDOM.VALUE(1,first_name_list.count));
        v_data := trunc(DBMS_RANDOM.VALUE(1,28)) || '/' || trunc(DBMS_RANDOM.VALUE(1,12)) || '/' || trunc(DBMS_RANDOM.VALUE(2018,2019)) || ' ' || trunc(DBMS_RANDOM.VALUE(8,17)) || ':' || trunc(DBMS_RANDOM.VALUE(0,60)) || ':' || trunc(DBMS_RANDOM.VALUE(0,60));
        insert into mese(id_masa,numar,status,data_rezervare,mentiune) VALUES(i,i,v_statusMasa,to_date( v_data, 'DD/MM/YYYY HH24:MI:SS' ),v_mentiuneRezervareMasa);
    else
        insert into mese(id_masa,numar,status,data_rezervare,mentiune) VALUES(i,i,v_statusMasa, null,'');
    end if;
  end loop;
  
  --CATEGORII (13)
  DBMS_OUTPUT.PUT_LINE('---Inserarea a 15 CATEGORII---');
  for i in 1..categorii_list.count loop          
    insert into categorii(id_categorie,nume) VALUES(i,categorii_list(i));
  end loop;
  
  --PRODUSE (1 milion)
  DBMS_OUTPUT.PUT_LINE('---Inserarea a 1.000.000 de PRODUSE, 1.000.000 INCASARI si 100 de COMENZI---');
  
  --bauturi carbogazoase
  DBMS_OUTPUT.PUT_LINE('Inserarea a 100.000 de BAUTURI CARBOGAZOASE');
  for i in 1..100000 loop      
    v_pretProdus := round(DBMS_RANDOM.VALUE(5,30),1);
    v_numeProdus := bauturi_carbogazoase_list(DBMS_RANDOM.VALUE(1,bauturi_carbogazoase_list.count)) || ' ' || cantitate_bautura_list(DBMS_RANDOM.VALUE(1,cantitate_bautura_list.count));
    v_descriereProdus := adjective_list(DBMS_RANDOM.VALUE(1,adjective_list.count));
    v_rndNumber := DBMS_RANDOM.VALUE(0,100);
    if(v_rndNumber >= 50) then
        v_stocLimitatProdus := 1;
    else
        v_stocLimitatProdus := 0;
    end if;
    
    insert into produse(id_produs,nume_produs,pret,descriere) VALUES(i,v_numeProdus,v_pretProdus,v_descriereProdus);
    insert into leg_cat_prod(id_produs,id_categorie) VALUES(i,1);
    if(v_stocLimitatProdus = 0) then
        insert into leg_stoc(id_produs,stoc) VALUES(i,null);
    else
        insert into leg_stoc(id_produs,stoc) VALUES(i,trunc(DBMS_RANDOM.VALUE(0,1000)));
    end if;
    
    --IN INCASARI
    v_cantitate := trunc(DBMS_RANDOM.VALUE(1,7));   
    v_data := trunc(DBMS_RANDOM.VALUE(1,28)) || '/' || trunc(DBMS_RANDOM.VALUE(1,12)) || '/' || trunc(DBMS_RANDOM.VALUE(2018,2019)) || ' ' || trunc(DBMS_RANDOM.VALUE(8,17)) || ':' || trunc(DBMS_RANDOM.VALUE(0,60)) || ':' || trunc(DBMS_RANDOM.VALUE(0,60));
    insert into incasari(id,id_produs,nume_produs,cantitate,pret,data_incasare) VALUES(i,i,v_numeProdus,v_cantitate,v_cantitate*v_pretProdus,to_date( v_data, 'DD/MM/YYYY HH24:MI:SS' ));
  
  end loop;

  --bauturi necarbogazoase
  DBMS_OUTPUT.PUT_LINE('Inserarea a 100.000 de BAUTURI NECARBOGAZOASE');
  for i in 100001..200000 loop      
    v_pretProdus := round(DBMS_RANDOM.VALUE(5,30),1);
    v_numeProdus := bauturi_necarbogazoase_list(DBMS_RANDOM.VALUE(1,bauturi_necarbogazoase_list.count)) || ' ' || cantitate_bautura_list(DBMS_RANDOM.VALUE(1,cantitate_bautura_list.count));
    v_descriereProdus := adjective_list(DBMS_RANDOM.VALUE(1,adjective_list.count));
    v_rndNumber := DBMS_RANDOM.VALUE(0,100);
    if(v_rndNumber >= 50) then
        v_stocLimitatProdus := 1;
    else
        v_stocLimitatProdus := 0;
    end if;
    
    insert into produse(id_produs,nume_produs,pret,descriere) VALUES(i,v_numeProdus,v_pretProdus,v_descriereProdus);
    insert into leg_cat_prod(id_produs,id_categorie) VALUES(i,2);
    if(v_stocLimitatProdus = 0) then
        insert into leg_stoc(id_produs,stoc) VALUES(i,null);
    else
        insert into leg_stoc(id_produs,stoc) VALUES(i,trunc(DBMS_RANDOM.VALUE(0,1000)));
    end if;
    
    --IN INCASARI
    v_cantitate := trunc(DBMS_RANDOM.VALUE(1,7));   
    v_data := trunc(DBMS_RANDOM.VALUE(1,28)) || '/' || trunc(DBMS_RANDOM.VALUE(1,12)) || '/' || trunc(DBMS_RANDOM.VALUE(2018,2019)) || ' ' || trunc(DBMS_RANDOM.VALUE(8,17)) || ':' || trunc(DBMS_RANDOM.VALUE(0,60)) || ':' || trunc(DBMS_RANDOM.VALUE(0,60));
    insert into incasari(id,id_produs,nume_produs,cantitate,pret,data_incasare) VALUES(i,i,v_numeProdus,v_cantitate,v_cantitate*v_pretProdus,to_date( v_data, 'DD/MM/YYYY HH24:MI:SS' ));
  
  end loop;

  --fresh-uri
  DBMS_OUTPUT.PUT_LINE('Inserarea a 100.000 de FRESH-URI');
  for i in 200001..300000 loop      
    v_pretProdus := round(DBMS_RANDOM.VALUE(10,30),1);
    v_numeProdus := freshuri_list(DBMS_RANDOM.VALUE(1,freshuri_list.count));
    v_descriereProdus := adjective_list(DBMS_RANDOM.VALUE(1,adjective_list.count));
    v_rndNumber := DBMS_RANDOM.VALUE(0,100);
    insert into produse(id_produs,nume_produs,pret,descriere) VALUES(i,v_numeProdus,v_pretProdus,v_descriereProdus);
    insert into leg_cat_prod(id_produs,id_categorie) VALUES(i,3);
    insert into leg_stoc(id_produs,stoc) VALUES(i,null);
    --IN INCASARI
    v_cantitate := trunc(DBMS_RANDOM.VALUE(1,7));   
    v_data := trunc(DBMS_RANDOM.VALUE(1,28)) || '/' || trunc(DBMS_RANDOM.VALUE(1,12)) || '/' || trunc(DBMS_RANDOM.VALUE(2018,2019)) || ' ' || trunc(DBMS_RANDOM.VALUE(8,17)) || ':' || trunc(DBMS_RANDOM.VALUE(0,60)) || ':' || trunc(DBMS_RANDOM.VALUE(0,60));
    insert into incasari(id,id_produs,nume_produs,cantitate,pret,data_incasare) VALUES(i,i,v_numeProdus,v_cantitate,v_cantitate*v_pretProdus,to_date( v_data, 'DD/MM/YYYY HH24:MI:SS' ));
  
  end loop; 
  
  --pizza  
  DBMS_OUTPUT.PUT_LINE('Inserarea a 100.000 de PIZZA');
  v_idComanda := 1;
  for i in 300001..400000 loop      
    v_pretProdus := round(DBMS_RANDOM.VALUE(20,40),1);
    v_numeProdus := pizza_list(DBMS_RANDOM.VALUE(1,pizza_list.count));
    v_descriereProdus := adjective_list(DBMS_RANDOM.VALUE(1,adjective_list.count));
    v_rndNumber := DBMS_RANDOM.VALUE(0,100);
    insert into produse(id_produs,nume_produs,pret,descriere) VALUES(i,v_numeProdus,v_pretProdus,v_descriereProdus);
    insert into leg_cat_prod(id_produs,id_categorie) VALUES(i,4);
    insert into leg_stoc(id_produs,stoc) VALUES(i,null);
    --IN INCASARI
    v_cantitate := trunc(DBMS_RANDOM.VALUE(1,7));   
    v_data := trunc(DBMS_RANDOM.VALUE(1,28)) || '/' || trunc(DBMS_RANDOM.VALUE(1,12)) || '/' || trunc(DBMS_RANDOM.VALUE(2018,2019)) || ' ' || trunc(DBMS_RANDOM.VALUE(8,17)) || ':' || trunc(DBMS_RANDOM.VALUE(0,60)) || ':' || trunc(DBMS_RANDOM.VALUE(0,60));
    insert into incasari(id,id_produs,nume_produs,cantitate,pret,data_incasare) VALUES(i,i,v_numeProdus,v_cantitate,v_cantitate*v_pretProdus,to_date( v_data, 'DD/MM/YYYY HH24:MI:SS' ));
    if(v_idComanda < 50) then
        --IN COMENZI
        v_nrMasa := trunc(DBMS_RANDOM.VALUE(1,50));
        insert into comenzi(id_comanda,numar_masa,id_produs,cantitate,pret,data_comanda) VALUES(v_idComanda,v_nrMasa,i,v_cantitate,v_cantitate*v_pretProdus,to_date( v_data, 'DD/MM/YYYY HH24:MI:SS' ));
        update mese set status='ocupata' where id_masa=v_nrMasa;
        v_idComanda := v_idComanda + 1;        
    end if;
  end loop; 
  
  --ciorbe  
  DBMS_OUTPUT.PUT_LINE('Inserarea a 100.000 de CIORBE');
  v_idComanda := 50;
  for i in 400001..500000 loop      
    v_pretProdus := round(DBMS_RANDOM.VALUE(20,40),1);
    v_numeProdus := ciorbe_list(DBMS_RANDOM.VALUE(1,ciorbe_list.count));
    v_descriereProdus := adjective_list(DBMS_RANDOM.VALUE(1,adjective_list.count));
    v_rndNumber := DBMS_RANDOM.VALUE(0,100);        
    insert into produse(id_produs,nume_produs,pret,descriere) VALUES(i,v_numeProdus,v_pretProdus,v_descriereProdus);
    insert into leg_cat_prod(id_produs,id_categorie) VALUES(i,5);
    insert into leg_stoc(id_produs,stoc) VALUES(i,null);
    --IN INCASARI
    v_cantitate := trunc(DBMS_RANDOM.VALUE(1,7));   
    v_data := trunc(DBMS_RANDOM.VALUE(1,28)) || '/' || trunc(DBMS_RANDOM.VALUE(1,12)) || '/' || trunc(DBMS_RANDOM.VALUE(2018,2019)) || ' ' || trunc(DBMS_RANDOM.VALUE(8,17)) || ':' || trunc(DBMS_RANDOM.VALUE(0,60)) || ':' || trunc(DBMS_RANDOM.VALUE(0,60));
    insert into incasari(id,id_produs,nume_produs,cantitate,pret,data_incasare) VALUES(i,i,v_numeProdus,v_cantitate,v_cantitate*v_pretProdus,to_date( v_data, 'DD/MM/YYYY HH24:MI:SS' ));
    if(v_idComanda < 100) then
        --IN COMENZI
        v_nrMasa := trunc(DBMS_RANDOM.VALUE(1,50));
        insert into comenzi(id_comanda,numar_masa,id_produs,cantitate,pret,data_comanda) VALUES(v_idComanda,v_nrMasa,i,v_cantitate,v_cantitate*v_pretProdus,to_date( v_data, 'DD/MM/YYYY HH24:MI:SS' ));
        update mese set status='ocupata' where id_masa=v_nrMasa;
        v_idComanda := v_idComanda + 1;        
    end if;
  end loop; 
  
  --restul categoriilor
  DBMS_OUTPUT.PUT_LINE('Inserarea a 500.000 de produse din RESTUL CATEGORIILOR');
  for i in 500001..1000000 loop      
    v_rndCateg := trunc(DBMS_RANDOM.VALUE(6,15));
    v_pretProdus := round(DBMS_RANDOM.VALUE(5,100),1);
    v_numeProdus := last_name_list(DBMS_RANDOM.VALUE(1,last_name_list.count));
    v_descriereProdus := adjective_list(DBMS_RANDOM.VALUE(1,adjective_list.count));
    v_rndNumber := DBMS_RANDOM.VALUE(0,100);
    if(v_rndNumber >= 50) then
        v_stocLimitatProdus := 1;
    else
        v_stocLimitatProdus := 0;
    end if;    
    
    insert into produse(id_produs,nume_produs,pret,descriere) VALUES(i,v_numeProdus,v_pretProdus,v_descriereProdus);
    insert into leg_cat_prod(id_produs,id_categorie) VALUES(i,v_rndCateg);
    if(v_stocLimitatProdus = 0) then
        insert into leg_stoc(id_produs,stoc) VALUES(i,null);
    else
        insert into leg_stoc(id_produs,stoc) VALUES(i,trunc(DBMS_RANDOM.VALUE(0,1000)));
    end if;
    --IN INCASARI
    v_cantitate := trunc(DBMS_RANDOM.VALUE(1,7));   
    v_data := trunc(DBMS_RANDOM.VALUE(1,28)) || '/' || trunc(DBMS_RANDOM.VALUE(1,12)) || '/' || trunc(DBMS_RANDOM.VALUE(2018,2019)) || ' ' || trunc(DBMS_RANDOM.VALUE(8,17)) || ':' || trunc(DBMS_RANDOM.VALUE(0,60)) || ':' || trunc(DBMS_RANDOM.VALUE(0,60));
    insert into incasari(id,id_produs,nume_produs,cantitate,pret,data_incasare) VALUES(i,i,v_numeProdus,v_cantitate,v_cantitate*v_pretProdus,to_date( v_data, 'DD/MM/YYYY HH24:MI:SS' ));
  
  end loop;
  
  --ISTORIC
  DBMS_OUTPUT.PUT_LINE('Inserarea a 1.000.000 de actiuni in ISTORIC');
  
  for i in 1..1000000 loop      
    select utilizator into v_utilizator from conturi where id_cont = trunc(DBMS_RANDOM.VALUE(1,20));    
    v_numeProdus := pizza_list(DBMS_RANDOM.VALUE(1,pizza_list.count));
    v_pretProdus := round(DBMS_RANDOM.VALUE(5,100),1);
    v_nrMasa := trunc(DBMS_RANDOM.VALUE(1,50));
    v_data := trunc(DBMS_RANDOM.VALUE(1,28)) || '/' || trunc(DBMS_RANDOM.VALUE(1,12)) || '/' || trunc(DBMS_RANDOM.VALUE(2018,2019)) || ' ' || trunc(DBMS_RANDOM.VALUE(8,17)) || ':' || trunc(DBMS_RANDOM.VALUE(0,60)) || ':' || trunc(DBMS_RANDOM.VALUE(0,60));
    insert into istoric(id,utilizator,comanda,numar_masa,pret_comanda,data) VALUES(i,v_utilizator,v_numeProdus,v_nrMasa,v_pretProdus,to_date( v_data, 'DD/MM/YYYY HH24:MI:SS' ));
  
  end loop;

end;

--Indecsi:
DROP INDEX INDEX_leg_catProd_idCategorie;

CREATE INDEX INDEX_leg_catProd_idCategorie ON leg_cat_prod (id_categorie);

DROP INDEX INDEX_leg_catProd_idProdus;

CREATE INDEX INDEX_leg_catProd_idProdus ON leg_cat_prod (id_produs);

DROP INDEX INDEX_incasari_produs_data;

CREATE INDEX INDEX_incasari_produs_data ON incasari (id_produs, nume_produs, data_incasare);


--Views:
create or replace view view_ProduseCategorii as 
	select c.nume as "Categorie", p.nume_produs as "Produs", p.pret, p.descriere 
	from produse p 
	join leg_cat_prod leg on p.id_produs = leg.id_produs
	join categorii c on c.id_categorie = leg.id_categorie;

create or replace view view_Comenzi as 
    select c.numar_masa as "Masa", p.nume_produs as "Produs", c.cantitate, c.pret as "Pret total"
    from produse p join comenzi c on c.id_produs = p.id_produs;

select * from view_ProduseCategorii;
--select * from view_Comenzi;


--select * from conturi;
--select * from mese;
--select * from categorii;
--select count(*) from produse;
--select * from comenzi;
--select * from incasari;
--select * from istoric;
--select * from leg_cat_prod;
--select * from leg_stoc;