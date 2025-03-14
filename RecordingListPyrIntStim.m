%% passive no cue
if(isunix == 0)
    listRecordingsNoCuePath = [...
%         'Z:\Raphael_tests\mice_expdata\ANM002\A002-20181004\A002-20181004-01\';
%         'Z:\Raphael_tests\mice_expdata\ANM002\A002-20181005\A002-20181005-01\';
%         'Z:\Raphael_tests\mice_expdata\ANM002\A002-20181009\A002-20181009-01\';
%         'Z:\Raphael_tests\mice_expdata\ANM002\A002-20181011\A002-20181011-01\';
%         'Z:\Raphael_tests\mice_expdata\ANM002\A002-20181016\A002-20181016-01\';
%         ...
%         'Z:\Raphael_tests\mice_expdata\ANM004\A004-20181027\A004-20181027-01\';
%         'Z:\Raphael_tests\mice_expdata\ANM004\A004-20181030\A004-20181030-01\';
        ...
        'Z:\Raphael_tests\mice_expdata\ANM009\A009-20190111\A009-20190111-02\'; % 3/105
        'Z:\Raphael_tests\mice_expdata\ANM009\A009-20190112\A009-20190112-01\'; % 4/156
        'Z:\Raphael_tests\mice_expdata\ANM009\A009-20190128\A009-20190128-01\'; 
        ...
        'Z:\Raphael_tests\mice_expdata\ANM007\A007-20190116\A007-20190116-01\';
        'Z:\Raphael_tests\mice_expdata\ANM007\A007-20190117\A007-20190117-01\'; % 3/85
        ...
        'Z:\Raphael_tests\mice_expdata\ANM010\A010-20190204\A010-20190204-01\'; %0/125
        'Z:\Raphael_tests\mice_expdata\ANM010\A010-20190205\A010-20190205-01\'; %1/154
        'Z:\Raphael_tests\mice_expdata\ANM010\A010-20190207\A010-20190207-01\'; 
    ];
else
    listRecordingsNoCuePath = [...
%         '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM002/A002-20181004/A002-20181004-01/';
%         '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM002/A002-20181005/A002-20181005-01/';
%         '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM002/A002-20181009/A002-20181009-01/';
%         '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM002/A002-20181011/A002-20181011-01/';
%         '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM002/A002-20181016/A002-20181016-01/';
%         ...
%         '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM004/A004-20181027/A004-20181027-01/';
%         '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM004/A004-20181030/A004-20181030-01/';
        ...
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM009/A009-20190111/A009-20190111-02/'; % 3/105
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM009/A009-20190112/A009-20190112-01/'; % 6/156
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM009/A009-20190128/A009-20190128-01/';
        ...
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM007/A007-20190116/A007-20190116-01/';
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM007/A007-20190117/A007-20190117-01/'; 
        ...
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM010/A010-20190204/A010-20190204-01/'; % 7/125
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM010/A010-20190205/A010-20190205-01/'; % 3/154
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM010/A010-20190207/A010-20190207-01/';
    ];
end

listRecordingsNoCueFileName = [...
%     'A002-20181004-01_DataStructure_mazeSection1_TrialType1';
%     'A002-20181005-01_DataStructure_mazeSection1_TrialType1';
%     'A002-20181009-01_DataStructure_mazeSection1_TrialType1';
%     'A002-20181011-01_DataStructure_mazeSection1_TrialType1';
%     'A002-20181016-01_DataStructure_mazeSection1_TrialType1';
%     ...
%     'A004-20181027-01_DataStructure_mazeSection1_TrialType1';
%     'A004-20181030-01_DataStructure_mazeSection1_TrialType1';
    ...
    'A009-20190111-02_DataStructure_mazeSection1_TrialType1';
    'A009-20190112-01_DataStructure_mazeSection1_TrialType1';
    'A009-20190128-01_DataStructure_mazeSection1_TrialType1';
    ...
    'A007-20190116-01_DataStructure_mazeSection1_TrialType1';
    'A007-20190117-01_DataStructure_mazeSection1_TrialType1';
    ...
    'A010-20190204-01_DataStructure_mazeSection1_TrialType1';
    'A010-20190205-01_DataStructure_mazeSection1_TrialType1';
    'A010-20190207-01_DataStructure_mazeSection1_TrialType1';
    ];

mazeSessionNoCue = [ ...
    1;
    1;
    1;
    ...
    1;
    1;
    ...
    1;
    1;
    1;
];

mazeSessionStartCue = [ ...
    2;
    2;
    2;
    ...
    2;
    2;
    ...
    2;
    2;
    2;
];

%% active with cue, lick to trigger reward
if(isunix == 0)
    listRecordingsActiveLickPath = [...
        'Z:\Raphael_tests\mice_expdata\ANM011\A011-20190218\A011-20190218-01\';
        'Z:\Raphael_tests\mice_expdata\ANM011\A011-20190219\A011-20190219-01\';
        'Z:\Raphael_tests\mice_expdata\ANM011\A011-20190220\A011-20190220-01\'; % 10/232
        ...        
        'Z:\Raphael_tests\mice_expdata\ANM012\A012-20190221\A012-20190221-01\';
        'Z:\Raphael_tests\mice_expdata\ANM012\A012-20190223\A012-20190223-01\'; %*
        'Z:\Raphael_tests\mice_expdata\ANM012\A012-20190224\A012-20190224-01\'; % 13/133    
        ...
        'Z:\Raphael_tests\mice_expdata\ANM013\A013-20190504\A013-20190504-01\';  % 1sec start cue   
        'Z:\Raphael_tests\mice_expdata\ANM013\A013-20190505\A013-20190505-01\'; % 11/171, 1sec start cue
        ...
        %'Z:\Raphael_tests\mice_expdata\ANM016\A016-20190529\A016-20190529-01\'; 
        'Z:\Raphael_tests\mice_expdata\ANM016\A016-20190531\A016-20190531-01\';  % 1sec start cue
        'Z:\Raphael_tests\mice_expdata\ANM016\A016-20190603\A016-20190603-01\'; % 13/90, 1sec start cue
        %'Z:\Raphael_tests\mice_expdata\ANM016\A016-20190608\A016-20190608-01\'; %drifting
        ...10
        'Z:\Raphael_tests\mice_expdata\ANM022\A022-20191105\A022-20191105-01\';  % stim and 2019/10/31 stim
        'Z:\Raphael_tests\mice_expdata\ANM022\A022-20191106\A022-20191106-01\';  % stim
        'Z:\Raphael_tests\mice_expdata\ANM022\A022-20191107\A022-20191107-01\';  % stim
        ...
        'Z:\Raphael_tests\mice_expdata\ANM023\A023-20191217\A023-20191217-01\';  % stim
        'Z:\Raphael_tests\mice_expdata\ANM023\A023-20191219\A023-20191219-01\';  % stim
        'Z:\Raphael_tests\mice_expdata\ANM023\A023-20191220\A023-20191220-01\';  % stim, artifacts
        ...
        'Z:\Raphael_tests\mice_expdata\ANM024\A024-20200119\A024-20200119-01\';  % stim
        'Z:\Raphael_tests\mice_expdata\ANM024\A024-20200120\A024-20200120-01\';  % stim
        'Z:\Raphael_tests\mice_expdata\ANM024\A024-20200122\A024-20200122-01\';  % stim
        'Z:\Raphael_tests\mice_expdata\ANM024\A024-20200123\A024-20200123-01\';  % stim
        ...20
        'Z:\Raphael_tests\mice_expdata\ANM025\A025-20200129\A025-20200129-01\';  % tagging only
        'Z:\Raphael_tests\mice_expdata\ANM025\A025-20200207\A025-20200207-01\';  % tagging only
        'Z:\Raphael_tests\mice_expdata\ANM025\A025-20200208\A025-20200208-01\';  % stim
        ...
        'Z:\Raphael_tests\mice_expdata\ANM028\A028-20200711\A028-20200711-01\';
        'Z:\Raphael_tests\mice_expdata\ANM028\A028-20200712\A028-20200712-01\';
        ...
        'Z:\Raphael_tests\mice_expdata\ANM029\A029-20200624\A029-20200624-01\';
        'Z:\Raphael_tests\mice_expdata\ANM029\A029-20200626\A029-20200626-01\';
        'Z:\Raphael_tests\mice_expdata\ANM029\A029-20200627\A029-20200627-01\';
        %'Z:\Raphael_tests\mice_expdata\ANM029\A029-20200716\A029-20200716-01\'; % medial septum 32 channel linear shank 
        ...
        'Z:\Raphael_tests\mice_expdata\ANM030\A030-20200811\A030-20200811-01\';
        'Z:\Raphael_tests\mice_expdata\ANM030\A030-20200812\A030-20200812-01\';
        ...30
        'Z:\Raphael_tests\mice_expdata\ANM030\A030-20200813\A030-20200813-01\';
        'Z:\Raphael_tests\mice_expdata\ANM030\A030-20200815\A030-20200815-01\';
        'Z:\Raphael_tests\mice_expdata\ANM030\A030-20200816\A030-20200816-01\';
        ...
        'Z:\Raphael_tests\mice_expdata\ANM030\A030-20200817\A030-20200817-01\';
        'Z:\Raphael_tests\mice_expdata\ANM037\A037-20201221\A037-20201221-01\'; % 0.5 sec black out, 0.5 sec cue
        'Z:\Raphael_tests\mice_expdata\ANM037\A037-20201222\A037-20201222-01\';
        ...% Updated Recording List 
        'Z:\Raphael_tests\mice_expdata\ANM039\A039-20210131\A039-20210131-01\';
        'Z:\Raphael_tests\mice_expdata\ANM039\A039-20210201\A039-20210201-01\';
        'Z:\Raphael_tests\mice_expdata\ANM039\A039-20210205\A039-20210205-01\';
        ...
        'Z:\Raphael_tests\mice_expdata\ANM040\A040-20210307\A040-20210307-01\';
        ...40
        'Z:\Raphael_tests\mice_expdata\ANM040\A040-20210308\A040-20210308-01\';
        'Z:\Raphael_tests\mice_expdata\ANM040\A040-20210309\A040-20210309-01\';
        ...
        'Z:\Raphael_tests\mice_expdata\ANM041\A041-20210215\A041-20210215-01\';
        'Z:\Raphael_tests\mice_expdata\ANM041\A041-20210216\A041-20210216-01\';
        'Z:\Raphael_tests\mice_expdata\ANM041\A041-20210219\A041-20210219-01\';
        ...
        'Z:\Raphael_tests\mice_expdata\ANM041\A041-20210221\A041-20210221-01\';
        'Z:\Raphael_tests\mice_expdata\ANM042\A042-20210313\A042-20210313-01\';
        'Z:\Raphael_tests\mice_expdata\ANM042\A042-20210316\A042-20210316-01\';
        ...
        'Z:\Raphael_tests\mice_expdata\ANM042\A042-20210317\A042-20210317-01\';
        'Z:\Raphael_tests\mice_expdata\ANM042\A042-20210319\A042-20210319-01\';
        ...50
        'Z:\Raphael_tests\mice_expdata\ANM044\A044-20210407\A044-20210407-01\';
        ...
        'Z:\Raphael_tests\mice_expdata\ANM044\A044-20210408\A044-20210408-01\';
        'Z:\Raphael_tests\mice_expdata\ANM044\A044-20210412\A044-20210412-01\';
        'Z:\Raphael_tests\mice_expdata\ANM044\A044-20210413\A044-20210413-01\';
        ...
        'Z:\Raphael_tests\mice_expdata\ANM046\A046-20210421\A046-20210421-01\';
        'Z:\Raphael_tests\mice_expdata\ANM046\A046-20210422\A046-20210422-01\';
        'Z:\Raphael_tests\mice_expdata\ANM046\A046-20210423\A046-20210423-01\';
        ...
        'Z:\Raphael_tests\mice_expdata\ANM046\A046-20210425\A046-20210425-01\';
        'Z:\Raphael_tests\mice_expdata\ANM046\A046-20210426\A046-20210426-01\';
        'Z:\Raphael_tests\mice_expdata\ANM046\A046-20210428\A046-20210428-02\';
        ...60
        'Z:\Raphael_tests\mice_expdata\ANM049\A049-20210721\A049-20210721-01\';
        'Z:\Raphael_tests\mice_expdata\ANM049\A049-20210722\A049-20210722-01\';
        'Z:\Raphael_tests\mice_expdata\ANM049\A049-20210731\A049-20210731-01\';
        ...
        'Z:\Raphael_tests\mice_expdata\ANM049\A049-20210801\A049-20210801-01\';
        'Z:\Raphael_tests\mice_expdata\ANM049\A049-20210802\A049-20210802-01\';
        'Z:\Raphael_tests\mice_expdata\ANM050\A050-20210828\A050-20210828-01\';
        ...
        'Z:\Raphael_tests\mice_expdata\ANM050\A050-20210829\A050-20210829-02\';
        'Z:\Raphael_tests\mice_expdata\ANM050\A050-20210831\A050-20210831-01\';
        'Z:\Raphael_tests\mice_expdata\ANM050\A050-20210901\A050-20210901-01\';
        ...
        'Z:\Raphael_tests\mice_expdata\ANM052\A052-20210915\A052-20210915-01\';
        ... 70
%         'Z:\Raphael_tests\mice_expdata\ANM052\A052-20210916\A052-20210916-01\';
        'Z:\Raphael_tests\mice_expdata\ANM052\A052-20210917\A052-20210917-01\';
        ...
        'Z:\Raphael_tests\mice_expdata\ANM053\A053-20211001\A053-20211001-01\';
        'Z:\Raphael_tests\mice_expdata\ANM053\A053-20211002\A053-20211002-01\';
        'Z:\Raphael_tests\mice_expdata\ANM053\A053-20211004\A053-20211004-01\';
        ...
        'Z:\Raphael_tests\mice_expdata\ANM053\A053-20211005\A053-20211005-01\';
        'Z:\Raphael_tests\mice_expdata\ANM053\A053-20211006\A053-20211006-01\';
        'Z:\Raphael_tests\mice_expdata\ANM054\A054-20211008\A054-20211008-01\';
        ...
        'Z:\Raphael_tests\mice_expdata\ANM054\A054-20211010\A054-20211010-01\';
        'Z:\Raphael_tests\mice_expdata\ANM054\A054-20211013\A054-20211013-01\';
        ...80
        'Z:\Raphael_tests\mice_expdata\ANM054\A054-20211015\A054-20211015-01\';
        ...
        'Z:\Raphael_tests\mice_expdata\ANM055\A055-20211028\A055-20211028-01\';
        'Z:\Raphael_tests\mice_expdata\ANM055\A055-20211030\A055-20211030-01\';
        'Z:\Raphael_tests\mice_expdata\ANM056\A056-20211110\A056-20211110-01\';
        ...
        'Z:\Raphael_tests\mice_expdata\ANM056\A056-20211111\A056-20211111-01\';
        'Z:\Raphael_tests\mice_expdata\ANM056\A056-20211112\A056-20211112-01\';
        'Z:\Raphael_tests\mice_expdata\ANM056\A056-20211114\A056-20211114-01\';
        ...
%         'Z:\Raphael_tests\mice_expdata\ANM056\A056-20211116\A056-20211116-01\';
        'Z:\Raphael_tests\mice_expdata\ANM056\A056-20211117\A056-20211117-01\';
%         'Z:\Raphael_tests\mice_expdata\ANM057\A057-20211203\A057-20211203-01\';...
%         ...
%         'Z:\Raphael_tests\mice_expdata\ANM057\A057-20211204\A057-20211204-01\';...
%         'Z:\Raphael_tests\mice_expdata\ANM057\A057-20211205\A057-20211205-01\';...
%         'Z:\Raphael_tests\mice_expdata\ANM057\A057-20211208\A057-20211208-01\';...
%         ...
%         'Z:\Raphael_tests\mice_expdata\ANM057\A057-20211209\A057-20211209-01\';...
%         'Z:\Raphael_tests\mice_expdata\ANM057\A057-20211210\A057-20211210-01\';
        
        
        
        
    ];
else
    listRecordingsActiveLickPath = [...
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM011/A011-20190218/A011-20190218-01/';
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM011/A011-20190219/A011-20190219-01/';
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM011/A011-20190220/A011-20190220-01/';
        ...
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM012/A012-20190221/A012-20190221-01/';
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM012/A012-20190223/A012-20190223-01/';
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM012/A012-20190224/A012-20190224-01/'; 
        ...
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM013/A013-20190504/A013-20190504-01/';
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM013/A013-20190505/A013-20190505-01/';
        ...
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM016/A016-20190531/A016-20190531-01/';
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM016/A016-20190603/A016-20190603-01/'; % 13 / 90
       % '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM016/A016-20190608/A016-20190608-01/'; 
        ...
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM022/A022-20191105/A022-20191105-01/';
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM022/A022-20191106/A022-20191106-01/';
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM022/A022-20191107/A022-20191107-01/';
        ...
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM023/A023-20191217/A023-20191217-01/';
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM023/A023-20191219/A023-20191219-01/';
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM023/A023-20191220/A023-20191220-01/';
        ...
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM024/A024-20200119/A024-20200119-01/';
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM024/A024-20200120/A024-20200120-01/';
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM024/A024-20200122/A024-20200122-01/';
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM024/A024-20200123/A024-20200123-01/';
        ...
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM025/A025-20190129/A025-20190129-01/';
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM025/A025-20200207/A025-20200207-01/';
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM025/A025-20200208/A025-20200208-01/';
        ...
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM028/A028-20200711/A028-20200711-01/';
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM028/A028-20200712/A028-20200712-01/'; 
        ...
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM029/A029-20200624/A029-20200624-01/';
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM029/A029-20200626/A029-20200626-01/';
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM029/A029-20200627/A029-20200627-01/';
       % '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM029/A029-20200716/A029-20200716-01/'; % medial septum 32 channel linear shank 
        ...
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM030/A030-20200811/A030-20200811-01/';
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM030/A030-20200812/A030-20200812-01/';
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM030/A030-20200813/A030-20200813-01/';
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM030/A030-20200815/A030-20200815-01/';
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM030/A030-20200816/A030-20200816-01/';
        ...
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM030/A030-20200817/A030-20200817-01/';
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM037/A037-20201221/A037-20201221-01/';
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM037/A037-20201222/A037-20201222-01/';
        ...% Updated Recording List 
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM039/A039-20210131/A039-20210131-01/';
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM039/A039-20210201/A039-20210201-01/';
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM039/A039-20210205/A039-20210205-01/';
        ...
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM040/A040-20210307/A040-20210307-01/';
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM040/A040-20210308/A040-20210308-01/';
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM040/A040-20210309/A040-20210309-01/';
        ...
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM041/A041-20210215/A041-20210215-01/';
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM041/A041-20210216/A041-20210216-01/';
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM041/A041-20210219/A041-20210219-01/';
        ...
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM041/A041-20210221/A041-20210221-01/';
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM042/A042-20210313/A042-20210313-01/';
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM042/A042-20210316/A042-20210316-01/';
        ...
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM042/A042-20210317/A042-20210317-01/';
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM042/A042-20210319/A042-20210319-01/';
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM044/A044-20210407/A044-20210407-01/';
        ...
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM044/A044-20210408/A044-20210408-01/';
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM044/A044-20210412/A044-20210412-01/';
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM044/A044-20210413/A044-20210413-01/';
        ...
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM046/A046-20210421/A046-20210421-01/';
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM046/A046-20210422/A046-20210422-01/';
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM046/A046-20210423/A046-20210423-01/';
        ...
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM046/A046-20210425/A046-20210425-01/';
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM046/A046-20210426/A046-20210426-01/';
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM046/A046-20210428/A046-20210428-02/'; 
        ...
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM049/A049-20210721/A049-20210721-01/';
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM049/A049-20210722/A049-20210722-01/';
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM049/A049-20210731/A049-20210731-01/';
        ...
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM049/A049-20210801/A049-20210801-01/';
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM049/A049-20210802/A049-20210802-01/';
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM050/A050-20210828/A050-20210828-01/';
        ...
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM050/A050-20210829/A050-20210829-02/';
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM050/A050-20210831/A050-20210831-01/';
%         '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM050/A050-20210901/A050-20210901-01/';
        ...
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM052/A052-20210915/A052-20210915-01/';
%         '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM052/A052-20210916/A052-20210916-01/';
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM052/A052-20210917/A052-20210917-01/';
        ...
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM053/A053-20211001/A053-20211001-01/';
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM053/A053-20211002/A053-20211002-01/';
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM053/A053-20211004/A053-20211004-01/';
        ...
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM053/A053-20211005/A053-20211005-01/';
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM053/A053-20211006/A053-20211006-01/';
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM054/A054-20211008/A054-20211008-01/';
        ...
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM054/A054-20211010/A054-20211010-01/';
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM054/A054-20211013/A054-20211013-01/';
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM054/A054-20211015/A054-20211015-01/';
        ...
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM055/A055-20211028/A055-20211028-01/';
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM055/A055-20211030/A055-20211030-01/';
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM056/A056-20211110/A056-20211110-01/';
        ...
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM056/A056-20211111/A056-20211111-01/';
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM056/A056-20211112/A056-20211112-01/';
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM056/A056-20211114/A056-20211114-01/';
        ...
%         '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM056/A056-20211116/A056-20211116-01/';
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM056/A056-20211117/A056-20211117-01/';
%         '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM057/A057-20211203/A057-20211203-01/';
%         ...
%         '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM057/A057-20211204/A057-20211204-01/';
%         '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM057/A057-20211205/A057-20211205-01/';
%         '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM057/A057-20211208/A057-20211208-01/';
%         ...
%         '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM057/A057-20211209/A057-20211209-01/';
%         '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM057/A057-20211210/A057-20211210-01/';

    ];
end

listRecordingsActiveLickFileName = [...
    'A011-20190218-01_DataStructure_mazeSection1_TrialType1';
    'A011-20190219-01_DataStructure_mazeSection1_TrialType1';
    'A011-20190220-01_DataStructure_mazeSection1_TrialType1';
    ...
    'A012-20190221-01_DataStructure_mazeSection1_TrialType1';   
    'A012-20190223-01_DataStructure_mazeSection1_TrialType1';
    'A012-20190224-01_DataStructure_mazeSection1_TrialType1';
    ...
    'A013-20190504-01_DataStructure_mazeSection1_TrialType1';   
    'A013-20190505-01_DataStructure_mazeSection1_TrialType1';
    ...   
    'A016-20190531-01_DataStructure_mazeSection1_TrialType1';
    'A016-20190603-01_DataStructure_mazeSection1_TrialType1';   
    %'A016-20190608-01_DataStructure_mazeSection1_TrialType1';
    ...
    'A022-20191105-01_DataStructure_mazeSection1_TrialType1';
    'A022-20191106-01_DataStructure_mazeSection1_TrialType1';
    'A022-20191107-01_DataStructure_mazeSection1_TrialType1';   
    ...
    'A023-20191217-01_DataStructure_mazeSection1_TrialType1';   
    'A023-20191219-01_DataStructure_mazeSection1_TrialType1';   
    'A023-20191220-01_DataStructure_mazeSection1_TrialType1';   
    ...
    'A024-20200119-01_DataStructure_mazeSection1_TrialType1';   
    'A024-20200120-01_DataStructure_mazeSection1_TrialType1';   
    'A024-20200122-01_DataStructure_mazeSection1_TrialType1'; 
    'A024-20200123-01_DataStructure_mazeSection1_TrialType1'; 
    ...
    'A025-20200129-01_DataStructure_mazeSection1_TrialType1';   
    'A025-20200207-01_DataStructure_mazeSection1_TrialType1';   
    'A025-20200208-01_DataStructure_mazeSection1_TrialType1'; 
    ...
    'A028-20200711-01_DataStructure_mazeSection1_TrialType1';
    'A028-20200712-01_DataStructure_mazeSection1_TrialType1';
    ...
    'A029-20200624-01_DataStructure_mazeSection1_TrialType1';
    'A029-20200626-01_DataStructure_mazeSection1_TrialType1';
    'A029-20200627-01_DataStructure_mazeSection1_TrialType1';
    %'A029-20200716-01_DataStructure_mazeSection1_TrialType1';
    ...
    'A030-20200811-01_DataStructure_mazeSection1_TrialType1';
    'A030-20200812-01_DataStructure_mazeSection1_TrialType1';
    'A030-20200813-01_DataStructure_mazeSection1_TrialType1';
    'A030-20200815-01_DataStructure_mazeSection1_TrialType1';
    'A030-20200816-01_DataStructure_mazeSection1_TrialType1';
    ...
    'A030-20200817-01_DataStructure_mazeSection1_TrialType1';
    'A037-20201221-01_DataStructure_mazeSection1_TrialType1';
    'A037-20201222-01_DataStructure_mazeSection1_TrialType1';
    ...% Updated Recording List 
    'A039-20210131-01_DataStructure_mazeSection1_TrialType1';
    'A039-20210201-01_DataStructure_mazeSection1_TrialType1';
    'A039-20210205-01_DataStructure_mazeSection1_TrialType1';
    ...
    'A040-20210307-01_DataStructure_mazeSection1_TrialType1';
    'A040-20210308-01_DataStructure_mazeSection1_TrialType1';
    'A040-20210309-01_DataStructure_mazeSection1_TrialType1';
    ...
    'A041-20210215-01_DataStructure_mazeSection1_TrialType1';
    'A041-20210216-01_DataStructure_mazeSection1_TrialType1';
    'A041-20210219-01_DataStructure_mazeSection1_TrialType1';
    ...
    'A041-20210221-01_DataStructure_mazeSection1_TrialType1';
    'A042-20210313-01_DataStructure_mazeSection1_TrialType1';
    'A042-20210316-01_DataStructure_mazeSection1_TrialType1';
    ...
    'A042-20210317-01_DataStructure_mazeSection1_TrialType1';
    'A042-20210319-01_DataStructure_mazeSection1_TrialType1';
    'A044-20210407-01_DataStructure_mazeSection1_TrialType1';
    ...
    'A044-20210408-01_DataStructure_mazeSection1_TrialType1';
    'A044-20210412-01_DataStructure_mazeSection1_TrialType1';
    'A044-20210413-01_DataStructure_mazeSection1_TrialType1';
    ...
    'A046-20210421-01_DataStructure_mazeSection1_TrialType1';
    'A046-20210422-01_DataStructure_mazeSection1_TrialType1';
    'A046-20210423-01_DataStructure_mazeSection1_TrialType1';
    ...
    'A046-20210425-01_DataStructure_mazeSection1_TrialType1';
    'A046-20210426-01_DataStructure_mazeSection1_TrialType1';
    'A046-20210428-02_DataStructure_mazeSection1_TrialType1';
    ...
    'A049-20210721-01_DataStructure_mazeSection1_TrialType1';
    'A049-20210722-01_DataStructure_mazeSection1_TrialType1';
    'A049-20210731-01_DataStructure_mazeSection1_TrialType1';
    ...
    'A049-20210801-01_DataStructure_mazeSection1_TrialType1';
    'A049-20210802-01_DataStructure_mazeSection1_TrialType1';
    'A050-20210828-01_DataStructure_mazeSection1_TrialType1';
    ...
    'A050-20210829-02_DataStructure_mazeSection1_TrialType1';
    'A050-20210831-01_DataStructure_mazeSection1_TrialType1';
%     'A050-20210901-01_DataStructure_mazeSection1_TrialType1';
    ...
    'A052-20210915-01_DataStructure_mazeSection1_TrialType1';
%     'A052-20210916-01_DataStructure_mazeSection1_TrialType1';
    'A052-20210917-01_DataStructure_mazeSection1_TrialType1';
    ...

    'A053-20211001-01_DataStructure_mazeSection1_TrialType1';
    'A053-20211002-01_DataStructure_mazeSection1_TrialType1';
    'A053-20211004-01_DataStructure_mazeSection1_TrialType1';
    ...
    'A053-20211005-01_DataStructure_mazeSection1_TrialType1';
    'A053-20211006-01_DataStructure_mazeSection1_TrialType1';
    'A054-20211008-01_DataStructure_mazeSection1_TrialType1';
    ...
    'A054-20211010-01_DataStructure_mazeSection1_TrialType1';
    'A054-20211013-01_DataStructure_mazeSection1_TrialType1';
    'A054-20211015-01_DataStructure_mazeSection1_TrialType1';
    ...
    'A055-20211028-01_DataStructure_mazeSection1_TrialType1';
    'A055-20211030-01_DataStructure_mazeSection1_TrialType1';
    'A056-20211110-01_DataStructure_mazeSection1_TrialType1';
    ...
    'A056-20211111-01_DataStructure_mazeSection1_TrialType1';
    'A056-20211112-01_DataStructure_mazeSection1_TrialType1';
    'A056-20211114-01_DataStructure_mazeSection1_TrialType1';
    ...
%     'A056-20211116-01_DataStructure_mazeSection1_TrialType1';
    'A056-20211117-01_DataStructure_mazeSection1_TrialType1';
%     'A057-20211203-01_DataStructure_mazeSection1_TrialType1';...
%     ...
%     'A057-20211204-01_DataStructure_mazeSection1_TrialType1';...
%     'A057-20211205-01_DataStructure_mazeSection1_TrialType1';...
%     'A057-20211208-01_DataStructure_mazeSection1_TrialType1';...
%     ...
%     'A057-20211209-01_DataStructure_mazeSection1_TrialType1';...
%     'A057-20211210-01_DataStructure_mazeSection1_TrialType1';...
    ];

mazeSessionActiveLick = [ ...
    1; ...
    1; ...
    1; ...
    ...
    1; ...
    1; ...
    1; ...
    ...
    1; ...
    1; ...
    ...
    5; ...
    3; ...
    %1; ...
    ...
    0;...
    0;...
    1; ...
    ...
    1; ...
    1; ...
    1; ...
    ...
    1; ...
    1; ...
    1; ...
    1; ...
    ...
    1; ...
    1; ...
    1; ...
    ...
    1; ...
    1; ...
    ...
    1; ...
    1; ...
    1; ...
    %1; ...
    ...
    1; ...
    1; ...
    1; ...
    1; ...
    1; ...
    ...
    1; ...
    1; ...
    1; ...
    ... % Updated Recording List 
    1;
    1;
    1;
    ...
    1;
    1;
    1;
    ...
    1;
    1;
    1;
    ...
    1;
    1;
    1;
    ...
    1;
    1;
    1;
    ...
    1;
    1;
    1;
    ...
    1;
    1;
    1;
    ...
    1;
    1;
    1;
    ...
    1;
    1;
    1;
    ...
    1;
    1;
    1;
    ...
    1;
    1;
%     1;
    ...
    1;
%     1;
    1;
    ...
    1;
    1;
    1;
    ...
    1;
    1;
    1;
    ...
    1;
    1;
    1;
    ...
    1;
    1;
    1;
    ...
    1;
    1;
    1;
    ...
%     1;
    1;
%     1;...
%     ...
%     1;...
%     1;...
%     1;...
%     ...
%     1;...
%     1;...
    ];
    
    
%% passive licking task
if(isunix == 0)
    listRecordingsPassiveLickPath = [...
        'Z:\Raphael_tests\mice_expdata\ANM013\A013-20190427\A013-20190427-01\';
        'Z:\Raphael_tests\mice_expdata\ANM013\A013-20190428\A013-20190428-01\';
        'Z:\Raphael_tests\mice_expdata\ANM013\A013-20190429\A013-20190429-01\';     
        ...
        'Z:\Raphael_tests\mice_expdata\ANM027\A027-20200308\A027-20200308-01\';  
        'Z:\Raphael_tests\mice_expdata\ANM027\A027-20200309\A027-20200309-01\';
        'Z:\Raphael_tests\mice_expdata\ANM027\A027-20200310\A027-20200310-01\';
        'Z:\Raphael_tests\mice_expdata\ANM027\A027-20200312\A027-20200312-01\';  
        'Z:\Raphael_tests\mice_expdata\ANM027\A027-20200313\A027-20200313-01\';
        'Z:\Raphael_tests\mice_expdata\ANM027\A027-20200314\A027-20200314-01\';
        ...
        'Z:\Raphael_tests\mice_expdata\ANM026\A026-20200318\A026-20200318-01\';
        'Z:\Raphael_tests\mice_expdata\ANM026\A026-20200319\A026-20200319-01\';  
        'Z:\Raphael_tests\mice_expdata\ANM026\A026-20200321\A026-20200321-01\';
        'Z:\Raphael_tests\mice_expdata\ANM026\A026-20200323\A026-20200323-01\';          
    ];

else
    listRecordingsPassiveLickPath = [...
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM013/A013-20190427/A013-20190427-01/';
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM013/A013-20190428/A013-20190428-01/';
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM013/A013-20190429/A013-20190429-01/';
        ...
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM027/A027-20200308/A027-20200308-01/';
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM027/A027-20200309/A027-20200309-01/';
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM027/A027-20200310/A027-20200310-01/';
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM027/A027-20200312/A027-20200312-01/';
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM027/A027-20200313/A027-20200313-01/';
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM027/A027-20200314/A027-20200314-01/';
        ...
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM026/A026-20200318/A026-20200318-01/';
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM026/A026-20200319/A026-20200319-01/';
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM026/A026-20200321/A026-20200321-01/';
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM026/A026-20200323/A026-20200323-01/';
             
    ];
end

listRecordingsPassiveLickFileName = [...
    'A013-20190427-01_DataStructure_mazeSection1_TrialType1';
    'A013-20190428-01_DataStructure_mazeSection1_TrialType1';
    'A013-20190429-01_DataStructure_mazeSection1_TrialType1';
    ...
    'A027-20200308-01_DataStructure_mazeSection1_TrialType1';
    'A027-20200309-01_DataStructure_mazeSection1_TrialType1';
    'A027-20200310-01_DataStructure_mazeSection1_TrialType1';
    'A027-20200312-01_DataStructure_mazeSection1_TrialType1';
    'A027-20200313-01_DataStructure_mazeSection1_TrialType1';
    'A027-20200314-01_DataStructure_mazeSection1_TrialType1';
    ...
    'A026-20200318-01_DataStructure_mazeSection1_TrialType1';
    'A026-20200319-01_DataStructure_mazeSection1_TrialType1';
    'A026-20200321-01_DataStructure_mazeSection1_TrialType1';
    'A026-20200323-01_DataStructure_mazeSection1_TrialType1';
  
    ];

mazeSessionPassiveLick = [ ...
    1; ...
    1; ...
    1; ...
    ...
    1; ...
    1; ...
    1; ...
    1; ...
    1; ...
    1; ...
    ...
    1; ...
    1; ...
    1; ...
    1; ...
    ];


%% passive licking task, with blackout but no start cue

if(isunix == 0)
    listRecordingsPassiveLickBlackoutNoCuePath = [...

        'Z:\Raphael_tests\mice_expdata\ANM058\A058-20211211\A058-20211211-01\';
        'Z:\Raphael_tests\mice_expdata\ANM058\A058-20211212\A058-20211212-01\';
        'Z:\Raphael_tests\mice_expdata\ANM058\A058-20211215\A058-20211215-01\';
        'Z:\Raphael_tests\mice_expdata\ANM058\A058-20211216\A058-20211216-01\';
        'Z:\Raphael_tests\mice_expdata\ANM058\A058-20211217\A058-20211217-01\';
        'Z:\Raphael_tests\mice_expdata\ANM058\A058-20211220\A058-20211220-01\';
        ...
        'Z:\Raphael_tests\mice_expdata\ANM060\A060-20211222\A060-20211222-01\';
        'Z:\Raphael_tests\mice_expdata\ANM060\A060-20211223\A060-20211223-01\';
        'Z:\Raphael_tests\mice_expdata\ANM060\A060-20211229\A060-20211229-01\';
        'Z:\Raphael_tests\mice_expdata\ANM060\A060-20211230\A060-20211230-01\';
        'Z:\Raphael_tests\mice_expdata\ANM060\A060-20211231\A060-20211231-01\';

    ];
else
     listRecordingsPassiveLickBlackoutNoCuePath = [...
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM058/A058-20211211/A058-20211211-01/';
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM058/A058-20211212/A058-20211212-01/';
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM058/A058-20211215/A058-20211215-01/';
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM058/A058-20211216/A058-20211216-01/';
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM058/A058-20211217/A058-20211217-01/';
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM058/A058-20211220/A058-20211220-01/';
        ...
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM060/A060-20211222/A060-20211222-01/';
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM060/A060-20211223/A060-20211223-01/';
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM060/A060-20211229/A060-20211229-01/';
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM060/A060-20211230/A060-20211230-01/';
        '~/Desktop/Network-Drives/Wang_Lab/Raphael_tests/mice_expdata/ANM060/A060-20211231/A060-20211231-01/';     
         ];
end

listRecordingsPassiveLickBlackoutNoCue = [...
    'A058-20211211-01_DataStructure_mazeSection1_TrialType1';
    'A058-20211212-01_DataStructure_mazeSection1_TrialType1';
    'A058-20211215-01_DataStructure_mazeSection1_TrialType1';
    'A058-20211216-01_DataStructure_mazeSection1_TrialType1';
    'A058-20211217-01_DataStructure_mazeSection1_TrialType1';
    'A058-20211220-01_DataStructure_mazeSection1_TrialType1';
    ...
    'A060-20211222-01_DataStructure_mazeSection1_TrialType1';
    'A060-20211223-01_DataStructure_mazeSection1_TrialType1';
    'A060-20211229-01_DataStructure_mazeSection1_TrialType1';
    'A060-20211230-01_DataStructure_mazeSection1_TrialType1';
    'A060-20211231-01_DataStructure_mazeSection1_TrialType1';
];


mazeSessionPassiveLickBlackoutNoCue = [...
    1; ...
    1; ...
    1; ...
    1; ...
    1; ...
    1; ...
    ...

    1; ...
    1; ...
    1; ...
    1; ...
    1; ...
    ];





