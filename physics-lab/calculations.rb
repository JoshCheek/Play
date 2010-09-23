#! /usr/bin/env ruby -Ku

require 'rubygems'
require 'units-system'

def gravitational_acceleration
  Units.units { 9.81 * m / s / s }
end

def generic_force(mass,xyval)
  Units.units do 
    force = mass.to(kg) * xyval * gravitational_acceleration
    force.to :N # newtons
  end.magnitude  
end

def f_x(mass,theta)
  generic_force mass , cos(theta)
end

def f_y(mass,theta)
  generic_force mass ,  sin(theta)
end


def format(magnitude)
  '%.3f' % magnitude
end

def smallest(*args)
  args.map { |n| n.abs }.sort.first
end

[ 
  [ 200 , 150 , 250 , 79.5  , 167.5 , 295.5 ] ,
  [ 100 , 150 , 100 , 41.0  , 180.5 , 318.5 ] ,
  [ 250 , 109 , 170 , 41.0  , 186.0 , 245.0 ] ,
  [ 200 , 300 , 105 , 31.0  , 198.0 , 355.0 ] ,
  [ 220 , 105 , 300 , 160.0 , 214.5 , 358.0 ] ,
].each_with_index do |(mass1,mass2,mass3,angle1,angle2,angle3),index|
  Units.units do
    mass1  *= g
    mass2  *= g
    mass3  *= g
    angle1 *= °
    angle2 *= °
    angle3 *= °
    
    fx1                    = f_x mass1 , angle1
    fy1                    = f_y mass1 , angle1
    fx2                    = f_x mass2 , angle2
    fy2                    = f_y mass2 , angle2
    fx3                    = f_x mass3 , angle3
    fy3                    = f_y mass3 , angle3
    sum_fx                 = fx1 + fx2 + fx3
    sum_fy                 = fy1 + fy2 + fy3
    Δ_from_0               = ::Math.sqrt sum_fx*sum_fx + sum_fy*sum_fy
    percent_error_x        = 100 * sum_fx.abs / smallest(fx1,fx2,fx3)
    percent_error_y        = 100 * sum_fy.abs / smallest(fy1,fy2,fy3)
    percent_error_x_plus_y = percent_error_x + percent_error_y


    puts "TRIAL #{index.next}"
    puts "F_x angle1           =  #{format fx1} N"
    puts "F_y angle1           =  #{format fy1} N"
    puts "F_x angle1           =  #{format fx2} N"
    puts "F_y angle1           =  #{format fy2} N"
    puts "F_x angle1           =  #{format fx3} N"
    puts "F_y angle1           =  #{format fy3} N"
    puts "sum_fx               =  #{format sum_fx} N"
    puts "sum_fy               =  #{format sum_fy} N"
    puts "Δ_from_0             =  #{format Δ_from_0} N"
    puts "percent_error_x      =  #{format percent_error_x} %"
    puts "percent_error_y      =  #{format percent_error_y} %"
    puts "percent error X + Y  =  #{format percent_error_x_plus_y} %"
    puts     
  end  
end

