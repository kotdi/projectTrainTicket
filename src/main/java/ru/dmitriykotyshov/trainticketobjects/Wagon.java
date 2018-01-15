package ru.dmitriykotyshov.trainticketobjects;

/**
 * Created by Дмитрий on 15.01.2018.
 */
public class Wagon {

    private int wagonId;
    private Train train;
    private String typeWagon;
    private boolean bioTiolet;
    private boolean airCondition;
    private int order;

    public Wagon(int wagonId, Train train, String typeWagon, boolean bioTiolet, boolean airCondition, int order) {
        this.wagonId = wagonId;
        this.train = train;
        this.typeWagon = typeWagon;
        this.bioTiolet = bioTiolet;
        this.airCondition = airCondition;
        this.order = order;
    }

    public Wagon() {
    }

    @Override
    public String toString() {
        return "Wagon{" +
                "wagonId=" + wagonId +
                ", train=" + train +
                ", typeWagon='" + typeWagon + '\'' +
                ", order=" + order +
                '}';
    }

    public boolean isBioTiolet() {
        return bioTiolet;
    }

    public void setBioTiolet(boolean bioTiolet) {
        this.bioTiolet = bioTiolet;
    }

    public boolean isAirCondition() {
        return airCondition;
    }

    public void setAirCondition(boolean airCondition) {
        this.airCondition = airCondition;
    }

    public int getWagonId() {
        return wagonId;
    }

    public void setWagonId(int wagonId) {
        this.wagonId = wagonId;
    }

    public Train getTrain() {
        return train;
    }

    public void setTrain(Train train) {
        this.train = train;
    }

    public String getTypeWagon() {
        return typeWagon;
    }

    public void setTypeWagon(String typeWagon) {
        this.typeWagon = typeWagon;
    }

    public int getOrder() {
        return order;
    }

    public void setOrder(int order) {
        this.order = order;
    }
}