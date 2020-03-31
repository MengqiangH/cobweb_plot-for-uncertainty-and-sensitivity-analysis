function cobweb()
clear
clc
prompt = 'Please input the path of Samples'' file [The default is .\\]£º';
path=input(prompt,'s');
default('path','.\');
prompt = 'Please input the name of Samples'' file [The default is samples.csv]:';
file_name=input(prompt,'s');
default('file_name','samples.csv')
file=dir([path,file_name]);
fid=fopen([path,file.name],'r','n','UTF-8');
samples=cell2mat(textscan(fid,'%f %f %f','Delimiter',',','HeaderLines',1));
for i=1:size(samples,2)
    x(i)=i;
    y_min(i)=-0.1;
    y_max(i)=1.1;
    plot([x(i),x(i)],[y_min(i),y_max(i)],'k','LineWidth',1)
    xlim([0.5 (size(samples,2)+0.5)])
    ylim([-0.5 1.2])
    hold on
end
for i=1:size(samples,2)
    num_variable(i)=size(unique(samples(:,i)),1);
end
for i=1:size(num_variable,2)
    for j=1:num_variable(i)
        p1(1:num_variable(i),i)=unique(samples(:,i));
        p2(1:num_variable(i),i)=(p1(1:num_variable(i),i)-min(p1(1:num_variable(i),i)))/(max(p1(1:num_variable(i),i))-min(p1(1:num_variable(i),i)));
        scatter(x(i),p2(j,i),[],[0 0 0],'+','LineWidth',1)
        if i<(size(num_variable,2)+1)/2
            text((x(i)-0.2),p2(j,i),1,num2str(p1(j,i)),'horizontalAlignment','center','Color','red')
        elseif i==(size(num_variable,2)+1)/2
            text((x(i)),p2(j,i),1,num2str(p1(j,i)),'horizontalAlignment','center','Color','red')
        else
            text((x(i)+0.2),p2(j,i),1,num2str(p1(j,i)),'horizontalAlignment','center','Color','red')
        end
    end
end
for i=1:size(samples,2)
    samples2(:,i)=(samples(:,i)-min(samples(:,i)))/(max(samples(:,i))-min(samples(:,i)));
end
for i=1:size(samples,1)
    for j=1:(length(x)-1)
        plot([x(j) x(j+1)],[samples2(i,j) samples2(i,j+1)],'b')
    end
end
for i=1:length(num_variable)
    prompt = ['Pleath input the ',num2str(i),'th x-label[The default is ',num2str(i),']:'];
        x_lable=input(prompt,'s');
        default('x_lable',num2str(i));        
        text(x(i),-0.2,x_lable,'horizontalAlignment','center','Color','black')
end
axis('off')
saveas(gcf,'cobweb plot','png')