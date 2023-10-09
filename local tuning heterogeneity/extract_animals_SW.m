function animal_sorted_BF = extract_animals_SW (BF)

% puts data after the SPL analysis into a format for IQR analysis. 

BF_animals = BF;
BF_animals_numbers = num2str(BF_animals(:,6));
BF_animals_numbers = BF_animals_numbers(:,1:end-7);
BF_animals_numbers = str2num(BF_animals_numbers);

BF_animals(:,6) = BF_animals_numbers;

animal_numbers = unique(BF_animals(:,6));

animal_sorted_BF = {};

for n = 1:length(animal_numbers)

counter = 1;
    
for i = 1:size(CeF_animals,1)

    if BF_animals(i,6) == animal_numbers(n)
    animal_sorted_BF{n}(counter,:) = BF_animals(i,:);
    counter = counter+1;
    end
    
end
    
end

end