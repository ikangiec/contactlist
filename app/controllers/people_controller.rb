class PeopleController < ApplicationController
  def index
    @people = Person.all
  end

  def show
    @person = Person.find(params[:id])
    @address = @person.address
  end

  def new
    @person = Person.new
    @person.build_address
  end

  def edit
    @person = Person.find(params[:id])
  end

  def create
    @person = Person.new(person_attr)
    if @person.save
      flash[:notice] = "This person has been saved."
      redirect_to people_url
    else
      render "new"
  end

  def update
    @person = Person.find(params[:id])
    if @person.update(person_attr)
      flash[:notice] = "This person has been updated."
      redirect_to people_url
    else
      render "edit"
    end
  end

  def destroy
    @person = Person.find(params[:id])
    @person.destroy
    redirect_to people_url
  end
end

private

  def person_attr
    params.require(:person).permit(:first_name, :last_name, :phone, address_attributes: [:street_address, :city, :state, :zip])
  end
end

