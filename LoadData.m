%clear all
clc

%% Variables and File Load
fm = 250; %Hz
xmlData = fileread('Dataset1.hl7');


%% Time information
%Time basics
startTime.pos = strfind(xmlData,'effectiveTime><low value="')+length('effectiveTime><low value="');
startTime.inclusivePos=startTime.pos+31;

endTime.pos = strfind(xmlData,'/><high value="')+length('/><high value="');
endTime.inclusivePos=endTime.pos+31;

dataChannels = length(startTime.pos);


%Time of channels
for i=1:dataChannels
    startTime.value(1,i)=str2num(xmlData(startTime.pos(i):startTime.pos(i)+17));
    startTime.inclusive=xmlData(startTime.inclusivePos(i):startTime.inclusivePos(i));

    endTime.value(1,i)=str2num(xmlData(endTime.pos(i):endTime.pos(i)+17));
    endTime.inclusive(1,i)=xmlData(endTime.inclusivePos(i):endTime.inclusivePos(i));

    %Time str2num
    startTime.year(1,i)=str2num(xmlData(startTime.pos(i):startTime.pos(i)+3));
    startTime.month(1,i)=str2num(xmlData(startTime.pos(i)+4:startTime.pos(i)+5));
    startTime.day(1,i)=str2num(xmlData(startTime.pos(i)+6:startTime.pos(i)+7));
    startTime.hour(1,i)=str2num(xmlData(startTime.pos(i)+8:startTime.pos(i)+9));
    startTime.minute(1,i)=str2num(xmlData(startTime.pos(i)+10:startTime.pos(i)+11));
    startTime.second(1,i)=str2num(xmlData(startTime.pos(i)+12:startTime.pos(i)+17));

    endTime.year(1,i)=str2num(xmlData(endTime.pos(i):endTime.pos(i)+3));
    endTime.month(1,i)=str2num(xmlData(endTime.pos(i)+4:endTime.pos(i)+5));
    endTime.day(1,i)=str2num(xmlData(endTime.pos(i)+6:endTime.pos(i)+7));
    endTime.hour(1,i)=str2num(xmlData(endTime.pos(i)+8:endTime.pos(i)+9));
    endTime.minute(1,i)=str2num(xmlData(endTime.pos(i)+10:endTime.pos(i)+11));
    endTime.second(1,i)=str2num(xmlData(endTime.pos(i)+12:endTime.pos(i)+17));
end

%% Signals Information
SequenceCode.start = strfind(xmlData,'<sequence><code code="')+length('<sequence><code code="');
SequenceCode.end = SequenceCode.start + 15;
% nomenclature=readtable('Table A-7-1-1.csv'); -- Values of MDC ISO11073

SequenceCode.value=[];
SequenceCode.text=SequenceCode.value;
for i=1:length(SequenceCode.start)
    string = strfind(xmlData(SequenceCode.start(i):SequenceCode.end(i)),'"');
    if isempty(string)
        SequenceCode.text = [SequenceCode.text, char(xmlData(SequenceCode.start(i):SequenceCode.end(i)))];
        if i==1
            SequenceCode.value = [SequenceCode.value, length(char(xmlData(SequenceCode.start(i):SequenceCode.end(i))))];
        else
            SequenceCode.value = [SequenceCode.value, SequenceCode.value(i-1)+length(char(xmlData(SequenceCode.start(i):SequenceCode.end(i))))];
        end
    else
        SequenceCode.text = [SequenceCode.text, char(xmlData(SequenceCode.start(i):SequenceCode.start(i)+string-2))];
        if i==1
            SequenceCode.value = [SequenceCode.value, length(char(xmlData(SequenceCode.start(i):SequenceCode.start(i)+string-2)))];
        else
            SequenceCode.value = [SequenceCode.value, SequenceCode.value(i-1)+length(char(xmlData(SequenceCode.start(i):SequenceCode.start(i)+string-2)))];
        end
    end
end


%% Setting the data channels taggs
% digitsIni = strfind(xmlData,'<digits>');
% digitsEnd = strfind(xmlData,'</digits>');
% 
% 
% ch1Chars = xmlData(digitsIni(1)+8:digitsEnd(1)-1);
% ch2Chars = xmlData(digitsIni(2)+8:digitsEnd(2)-1);
% ch3Chars = xmlData(digitsIni(3)+8:digitsEnd(3)-1);
% 
% ECGData = Char2ECG(ch1Chars,ch2Chars,ch3Chars);
% 
% save('MJordaData.mat','ECGData');

%% Plotting the data
% load('AOllerData.mat')
% time=[1/fm:1/fm:length(ECGData.ch1)/fm];
% 
% hold on;
% 
% timescale=1; %seconds
% subplot(3,1,1);
% plot(time/timescale,ECGData.ch1);
% title('AOllerData');
% xlim([0,max(time/timescale)]);
% ylim([-2100,2100]);
% xlabel('seconds');
% ylabel('Channel 1');
% 
% 
% timescale=60; %minutes
% subplot(3,1,2);
% plot(time/timescale,ECGData.ch2);
% xlim([0,max(time/timescale)]);
% ylim([-2100,2100]);
% xlabel('minutes');
% ylabel('Channel 2');
% 
% timescale=3600; %hours
% subplot(3,1,3);
% plot(time/timescale,ECGData.ch3);
% xlim([0,max(time/timescale)]);
% ylim([-2100,2100]);
% xlabel('hours');
% ylabel('Channel 3');
