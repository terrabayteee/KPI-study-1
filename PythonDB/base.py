# -*- coding: utf-8 -*-
import pickle

base = []
firmnumb = 0

class ItemFirm:
    def __init__(self, string, numb):
        self.__name = string.upper()
        self.__firmnum = numb
        self.list = []
        self.numberofmodel = 0
        self.currentnumbofmodels = 0

    def set_name(self, string):
        self.__name = string.upper()

    def get_name(self):
        return self.__name

    def set_firmnumb(self, numb):
        self.__firmnum = numb

    def get_firmnumb(self):
        return self.__firmnumb

    def inccurrentnumbofmodels(self):
        self.currentnumbofmodels =+ 1

    def deccurrentnumbofmodels(self):
        self.currentnumbofmodels =- 1



class ItemModel:
    def __init__(self, string, c , numb):
        self.__name = string.upper()
        self.__capacity = c
        self.__modelnumb = numb

    def set_name(self, string):
        self.__name = string.upper()

    def get_name(self):
        return self.__name

    def set_capacity(self, c):
        self.__capacity = c

    def get_capacity(self):
        return self.__capacity

    def set_modelnumb(self, numb):
        self.__modelnumb = numb

    def get_modelnumb(self):
        return self.__modelnumb


def new_firm():
    firmnumb =+ 1
    base.append(ItemFirm(raw_input("Название новой фирмы: ").upper(),firmnumb))


def new_model():
    b = raw_input("Название фирмы: ").upper()
    for i in base:
        if b == i.get_name():
            i.numberofmodel += 1
            i.inccurrentnumbofmodels
            i.list.append(ItemModel(raw_input("Название модели: ").upper(), input("обьем двигателя: ") , i.numberofmodel))
            return
    print ("Нет такой фирмы.")


def change_firm():
    b = raw_input("Название фирмы: ").upper()
    for i in base:
        if b == i.get_name():
            i.set_name(raw_input("Новое название: "))
            return
    print ("Нет такой фирмы.")


def change_model():
    b = raw_input("Название фирмы: ").upper()
    for i in base:
        if b == i.get_name():

            g = raw_input("Название модели: ").upper()
            for j in i.list:
                if g == j.get_name():
                    j.set_name(raw_input("Новое название: "))
                    j.set_capacity(input("и обьем двигателя: "))
                    return
    print ("Нет такой фирмы.")


def del_firm():
    b = raw_input("Название фирмы: ").upper()
    for i in base:
        if (i.get_name() == b) and (i.currentnumbofmodels == 0):
            base.remove(i)
    if i.currentnumbofmodels == 0 and i.get_name() != b :
        print ("Нет такой фирмы.")
    if i.currentnumbofmodels != 0 and i.get_name() == b:
        print ("Вы не можете удалить фирму у которой есть модели")


def del_model():
    b = raw_input("Фирма: ").upper()
    for i in base:
        if i.get_name() == b:
            g = raw_input("Модель:").upper()
            for j in i.list:
                if j.get_name() == g:
                    i.deccurrentnumbofmodels
                    i.list.remove(j)
                    return
    print ("Нет такой фирмы.")


def filter():
    for i in base:
        for j in i.list:
            if (j.get_capacity > 2):
                print(j.get_name())


def save_base():
    f = open('base.pickle', 'wb')
    pickle.dump(base, f)
    f.close()


def refresh_from_f():
    f = open('base.pickle', 'rb')
    global base
    base = list(pickle.load(f))
    f.close()


def del_base():
    global base
    base = []
    with open('base.pickle', 'wb') as f:
        pickle.dump(base, f)


def view_base():
    if base.__len__() == 0:
        print ("База пуста")
    else:
        for i in base:
            print ("Фирма: " + i.get_name())
            for j in i.list:
                print (j.get_name() + "  " + str(j.get_capacity()) + " обьем двигателя")
            print




